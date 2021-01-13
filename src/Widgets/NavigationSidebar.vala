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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/NavigationSidebarRow.ui")]
public class Rpy.NavigationSidebarRow : Gtk.ListBoxRow
{
	private Rpy.View? _view;


	public string? icon_name { get; private set; }

	public Rpy.View? view
	{
		get { return this._view; }
		construct
		{
			if (this._view == value)
				return;

			this._view = value;

			this.icon_name = ((!) this._view).icon_name;
			this.label = ((!) this._view).title;
		}
	}

	public string? label { get; private set; }


	public NavigationSidebarRow (Rpy.View view)
	{
		GLib.Object (
			view: view
		);
	}
}

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/NavigationSidebar.ui")]
public class Rpy.NavigationSidebar : Gtk.Widget
{
	[GtkChild] private Gtk.ListBox _list_box;

	private GLib.ListModel? _model;


	public GLib.ListModel? model
	{
		get { return this._model; }
		set
		{
			if (this._model == value)
				return;

			if (this._model != null)
				this._list_box.bind_model (null, null);

			this._model = value;

			if (this._model != null)
				this._list_box.bind_model (this._model, this.get_row_from_view);
		}
	}


	public signal void view_selected (Rpy.View view);


	private void add_separator_if_applicable (Gtk.ListBoxRow row, Gtk.ListBoxRow? before)
		requires (row is Rpy.NavigationSidebarRow)
		requires (((Rpy.NavigationSidebarRow) row).view != null)
	{
		if (before == null)
			return;

		GLib.return_if_fail (before is Rpy.NavigationSidebarRow);
		GLib.return_if_fail (((Rpy.NavigationSidebarRow) before).view != null);

		Rpy.View previous_view = (!) ((Rpy.NavigationSidebarRow) before).view;
		Rpy.View view = (!) ((Rpy.NavigationSidebarRow) row).view;

		if (previous_view.visible_on_narrow != view.visible_on_narrow)
			row.set_header (new Gtk.Separator (Gtk.Orientation.VERTICAL));
	}

	private Gtk.Widget get_row_from_view (GLib.Object item)
		requires (item is Rpy.View)
	{
		return new Rpy.NavigationSidebarRow ((Rpy.View) item);
	}

	[GtkCallback]
	private void on_list_box_row_selected (Gtk.ListBoxRow? row)
	{
		if (row == null)
			return;

		GLib.return_if_fail (row is Rpy.NavigationSidebarRow);
		GLib.return_if_fail (((Rpy.NavigationSidebarRow) row).view != null);

		this.view_selected ((!) ((Rpy.NavigationSidebarRow) row).view);
	}


	public void select_view (Rpy.View view)
		requires (this.model != null)
	{
		var i = 0;
		GLib.Object? object = ((!) this.model).get_object (i);

		while (object != null)
		{
			GLib.return_if_fail (object is Rpy.View);
			var view_to_compare = (Rpy.View) object;

			if (view_to_compare == view)
			{
				Gtk.ListBoxRow? row = this._list_box.get_row_at_index (i);
				this._list_box.select_row (row);
				return;
			}

			object = ((!) this.model).get_object (++i);
		}
	}

	public void unselect_all ()
	{
		this._list_box.unselect_all ();
	}


	construct
	{
		this._list_box.set_header_func (this.add_separator_if_applicable);
	}

	static construct
	{
		set_css_name ("navigationsidebar");
	}
}
