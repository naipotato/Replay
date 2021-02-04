/* Replay - Explore and watch YouTube videos
 * Copyright 2019 - 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * Replay is free software: you can redistribute it and/or modify it under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * Replay is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Replay.  If not, see <https://www.gnu.org/licenses/>.
 */

public struct Rpy.MainPageParameters
{
	public Rpy.ObservableList<Rpy.View>? views;
	public Rpy.LibraryView? library_view;
	public Rpy.SearchView? search_view;
}

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/MainPage.ui")]
public class Rpy.MainPage : Rpy.Page
{
	[GtkChild] private unowned Hdy.ViewSwitcherBar _bottom_bar;
	[GtkChild] private unowned Gtk.Stack _content_stack;
	[GtkChild] private unowned Hdy.Flap _flap;
	[GtkChild] private unowned Rpy.MainHeaderBar _header_bar;
	[GtkChild] private unowned Rpy.ViewList _sidebar;
	[GtkChild] private unowned Hdy.SwipeGroup _headerbar_swipe_group;
	[GtkChild] private unowned Hdy.Leaflet _headerbar_leaflet;
	[GtkChild] private unowned Rpy.SecondaryHeaderBar _secondary_header_bar;

	private Rpy.LibraryView? _library_view;
	private unowned GLib.Binding? _narrow_header_bar_binding;
	private Rpy.View? _view_before_library;
	private Rpy.View? _view_before_searching;
	private unowned GLib.Binding? _reveal_bottom_bar_binding;
	private Rpy.SearchView? _search_view;


	public override void on_navigated_to (GLib.Value? parameter = null)
		requires (parameter != null)
		requires (((!) parameter).holds (typeof (Rpy.MainPageParameters)))
	{
		var parameters = (Rpy.MainPageParameters*) ((!) parameter).get_boxed ();
		GLib.return_if_fail (parameters.views != null);

		this._sidebar.model = parameters.views;

		foreach (Rpy.View view in (!) parameters.views)
		{
			Gtk.StackPage page = this._content_stack.add_child (view);

			view.bind_property ("icon-name", page, "icon-name",
				GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);
			view.bind_property ("title", page, "title",
				GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);
		}

		GLib.return_if_fail (parameters.search_view != null);
		this._search_view = parameters.search_view;
		this._content_stack.add_child ((!) this._search_view);

		GLib.return_if_fail (parameters.library_view != null);
		this._library_view = (!) parameters.library_view;

		Gtk.StackPage page = this._content_stack.add_child ((!) this._library_view);
		((!) this._library_view).bind_property ("icon-name", page, "icon-name",
			GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);
		((!) this._library_view).bind_property ("title", page, "title",
			GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);

		((!) parameters.views).add_all ((!) ((!) this._library_view).views);

		this.update_sidebar_selected_view ();
	}


	[GtkCallback]
	private void navigate ()
		requires (this._sidebar.selected_view != null)
	{
		if (this._content_stack.visible_child != (!) this._library_view &&
		    ((!) this._sidebar.selected_view).category == Rpy.ViewCategory.SECONDARY)
		{
			this._view_before_library = (Rpy.View) this._content_stack.visible_child;
		}

		switch (((!) this._sidebar.selected_view).category)
		{
			case Rpy.ViewCategory.MAIN:
				this._content_stack.visible_child = (!) this._sidebar.selected_view;
				break;
			case Rpy.ViewCategory.SECONDARY:
				((!) this._library_view).leaflet.visible_child = ((!) this._library_view).stack;
				((!) this._library_view).stack.visible_child = (!) this._sidebar.selected_view;
				this._content_stack.visible_child = (!) this._library_view;
				break;
		}
	}

	[GtkCallback]
	private void on_flap_folded ()
	{
		if (this._flap.folded)
		{
			this._headerbar_swipe_group.add_swipeable (((!) this._library_view).leaflet);

			if (((!) this._library_view).leaflet.visible_child == ((!) this._library_view).stack)
			{
				this._headerbar_leaflet.visible_child = this._secondary_header_bar;
			}
		}
		else
		{
			unowned GLib.SList<Hdy.Swipeable> swipeables = this._headerbar_swipe_group.get_swipeables ();
			if (swipeables.index (((!) this._library_view).leaflet) != -1)
			{
				this._headerbar_swipe_group.remove_swipeable (((!) this._library_view).leaflet);
				this._headerbar_leaflet.visible_child = this._header_bar;
			}

			if (((!) this._library_view).leaflet.visible_child == ((!) this._library_view).stack)
			{
				this._sidebar.selected_view = (Rpy.View) ((!) this._library_view).stack.visible_child;
			}
			else if (this._content_stack.visible_child == (!) this._library_view)
			{
				this._content_stack.visible_child = (!) this._view_before_library;
			}
		}
	}

	[GtkCallback]
	private void on_secondary_header_bar_back_requested ()
	{
		((!) this._library_view).leaflet.navigate (Hdy.NavigationDirection.BACK);
	}

	[GtkCallback]
	private void update_sidebar_selected_view ()
		requires (this._content_stack.visible_child is Rpy.View)
	{
		if (this._content_stack.transition_running ||
		    this._content_stack.visible_child == (!) this._library_view ||
		    this._content_stack.visible_child == (!) this._search_view)
		{
			return;
		}

		this._sidebar.selected_view = (Rpy.View) this._content_stack.visible_child;
	}

	[GtkCallback]
	private void update_ui_mode ()
	{
		if (this._header_bar.search_mode)
		{
			if (this._narrow_header_bar_binding != null)
			{
				((!) this._narrow_header_bar_binding).unbind ();
			}

			if (this._reveal_bottom_bar_binding != null)
			{
				((!) this._reveal_bottom_bar_binding).unbind ();
			}

			this._flap.fold_policy = Hdy.FlapFoldPolicy.ALWAYS;
			this._bottom_bar.reveal = false;

			this._view_before_searching = (Rpy.View) this._content_stack.visible_child;
			if (this._search_view != null)
			{
				this._content_stack.visible_child = (!) this._search_view;
			}
		}
		else
		{
			if (this._view_before_searching != null)
			{
				this._content_stack.visible_child = (!) this._view_before_searching;
			}

			this._flap.fold_policy = Hdy.FlapFoldPolicy.AUTO;

			this._narrow_header_bar_binding = this._flap.bind_property ("folded", this._header_bar, "narrow-mode",
				GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);
			this._reveal_bottom_bar_binding = this._flap.bind_property ("folded", this._bottom_bar, "reveal",
				GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);
		}
	}


	construct
	{
		GLib.Application? app = GLib.Application.get_default ();
		if (app != null)
		{
			GLib.return_if_fail (app is Gtk.Application);

			var gtk_app = (Gtk.Application) app;
			this._header_bar.key_capture_widget = gtk_app.active_window;
		}

		this._header_bar.title = GLib.Environment.get_application_name ();
		this.update_ui_mode ();
	}
}
