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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/MainPage.ui")]
public class Rpy.MainPage : Rpy.Page
{
	[GtkChild] private Hdy.Flap _flap;
	[GtkChild] private Rpy.MainHeaderBar _header_bar;
	[GtkChild] private Rpy.NavigationSidebar _navigation_sidebar;
	[GtkChild] private Gtk.Stack _stack;
	[GtkChild] private Hdy.ViewSwitcherBar _view_switcher_bar;

	private string? _current_view_name;
	private unowned GLib.Binding _header_bar_binding;
	private unowned GLib.Binding _view_switcher_bar_binding;


	private void add_view_to_stack (Rpy.View view)
		requires (view.name != null)
	{
		Gtk.StackPage page = this._stack.add_named ((!) view, (!) view.name);

		if (view.visible_on_narrow)
		{
			if (view.icon_name != null)
				page.icon_name = (!) view.icon_name;

			if (view.title != null)
				page.title = (!) view.title;
		}
	}

	[GtkCallback]
	private void on_flap_folded_changed ()
		requires (this._stack.visible_child is Rpy.View)
	{
		var view = (Rpy.View) this._stack.visible_child;

		if (this._flap.folded && !view.visible_on_narrow)
			this._stack.visible_child_name = "library";
		else if (!this._flap.folded && !view.visible_on_normal)
			this._stack.visible_child_name = "favs";
	}

	[GtkCallback]
	private void on_header_bar_search_mode_changed ()
	{
		if (this._header_bar.search_mode)
		{
			this._header_bar_binding.unbind ();
			this._view_switcher_bar_binding.unbind ();

			this._flap.fold_policy = Hdy.FlapFoldPolicy.ALWAYS;
			this._view_switcher_bar.reveal = false;

			this._stack.visible_child_name = "search";
		}
		else
		{
			this._header_bar_binding = this._flap.bind_property ("folded", this._header_bar, "narrow-mode",
				GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);
			this._view_switcher_bar_binding = this._flap.bind_property ("folded", this._view_switcher_bar, "reveal",
				GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);

			this._flap.fold_policy = Hdy.FlapFoldPolicy.AUTO;

			if (this._current_view_name != null)
				this._stack.visible_child_name = (!) this._current_view_name;
		}
	}

	[GtkCallback]
	private void on_navigation_sidebar_view_selected (Rpy.View view)
		requires (view.visible_on_normal)
	{
		if (this._stack.visible_child == view)
			return;

		this._stack.visible_child = view;
	}

	[GtkCallback]
	private void on_stack_visible_child_changed ()
		requires (this._navigation_sidebar.model != null)
		requires (this._stack.visible_child is Rpy.View)
	{
		var view = (Rpy.View) this._stack.visible_child;

		if (view.visible_on_normal)
			this._navigation_sidebar.select_view (view);
		else
			this._navigation_sidebar.unselect_all ();

		if (this._stack.visible_child_name != "search")
			this._current_view_name = this._stack.visible_child_name;
	}


	public override void on_navigated_to (GLib.Value? parameter = null)
		requires (parameter != null)
		requires (((!) parameter).holds (typeof (Rpy.MainViewModel)))
	{
		var view_model = (Rpy.MainViewModel) ((!) parameter).get_object ();

		var filter = new Gtk.CustomFilter (item => ((Rpy.View) item).visible_on_normal);
		this._navigation_sidebar.model = new Gtk.FilterListModel (view_model.views, filter);

		foreach (Rpy.View view in view_model.views)
			this.add_view_to_stack (view);
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
		this.on_header_bar_search_mode_changed ();
	}
}
