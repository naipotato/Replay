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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/ViewListRow.ui")]
public class Rpy.ViewListRow : Gtk.ListBoxRow
{
	private Rpy.View? _view;


	public string? icon_name { get; set; }
	public string? label { get; set; }

	public Rpy.View? view
	{
		get { return this._view; }
		construct
		{
			if (value == null)
			{
				return;
			}

			this._view = value;

			((!) this._view).bind_property ("icon-name", this, "icon-name",
				GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);
			((!) this._view).bind_property ("title", this, "label",
				GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);
		}
	}


	public ViewListRow (Rpy.View view)
	{
		GLib.Object (
			view: view
		);
	}
}

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/ViewList.ui")]
public class Rpy.ViewList : Gtk.Widget
{
	[GtkChild] private unowned Gtk.ListBox _list_box;

	private GLib.ListModel? _model;
	private Rpy.View? _selected_view;


	public GLib.ListModel? model
	{
		get { return this._model; }
		set
		{
			if (value == this._model)
			{
				return;
			}

			if (this._model != null)
			{
				this._list_box.bind_model (null, null);
			}

			this._model = value;

			if (this._model != null)
			{
				this._list_box.bind_model (this._model, item =>
				{
					GLib.return_val_if_fail (item is Rpy.View, null);
					return new Rpy.ViewListRow ((Rpy.View) item);
				});
			}
		}
	}

	public Rpy.View? selected_view
	{
		get { return this._selected_view; }
		set
		{
			if (value == this._selected_view)
			{
				return;
			}

			this._selected_view = value;

			if (this.model != null)
			{
				bool view_not_found = Rpy.list_model_foreach<Rpy.View> ((!) this.model, (item, index) =>
				{
					if (item == this._selected_view)
					{
						Gtk.ListBoxRow? row = this._list_box.get_row_at_index ((int) index);
						this._list_box.select_row (row);

						return false;
					}

					return true;
				});

				if (view_not_found)
				{
					this._list_box.unselect_all ();
				}
			}
		}
	}

	[GtkCallback]
	private void update_selected_view (Gtk.ListBoxRow? row)
	{
		if (row == null)
		{
			return;
		}

		GLib.return_if_fail (row is Rpy.ViewListRow);

		var sidebar_row = (Rpy.ViewListRow) row;
		GLib.return_if_fail (sidebar_row.view != null);

		this.selected_view = sidebar_row.view;
	}


	construct
	{
		this._list_box.set_header_func ((row, before) =>
		{
			if (before == null)
			{
				return;
			}

			GLib.return_if_fail (row is Rpy.ViewListRow && before is Rpy.ViewListRow);

			var sidebar_row = (Rpy.ViewListRow) row;
			var sidebar_before = (Rpy.ViewListRow) before;

			GLib.return_if_fail (sidebar_row.view != null && sidebar_before.view != null);

			if (((!) sidebar_row.view).category != ((!) sidebar_before.view).category)
			{
				row.set_header (new Gtk.Separator (Gtk.Orientation.VERTICAL));
			}
		});
	}

	static construct
	{
		set_css_name ("viewlist");
	}
}
