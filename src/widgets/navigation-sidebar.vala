/* navigation-sidebar.vala
 *
 * Copyright 2020-2021 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

/**
 *
 */
public class Rpy.NavigationSidebarRow : Gtk.ListBoxRow {
	/**
	 *
	 */
	[Description (nick = "View", blurb = "")]
	public View? view { get; construct; }

	/**
	 *
	 */
	public NavigationSidebarRow (View view) {
		Object (
			view: view
		);
	}
}

/**
 *
 */
[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/navigation-sidebar.ui")]
public class Rpy.NavigationSidebar : Gtk.Widget {
	private ListModel? _model;
	private View? _selected_view;

	[GtkChild (name = "list-box")]
	private unowned Gtk.ListBox _list_box;

	/**
	 *
	 */
	[Description (nick = "Model", blurb = "")]
	public ListModel? model {
		get { return this._model; }
		set {
			if (value == this._model) {
				return;
			}

			if (this._model != null) {
				this._list_box.bind_model (null, null);
			}

			this._model = value;

			if (this._model != null) {
				this._list_box.bind_model (this._model, item => {
					return_val_if_fail (item is View, null);
					return new NavigationSidebarRow ((View) item);
				});
			}
		}
	}

	/**
	 *
	 */
	[Description (nick = "Selected View", blurb = "")]
	public View? selected_view {
		get { return this._selected_view; }
		set {
			if (value == this._selected_view) {
				return;
			}

			if (this.model == null) {
				warning ("You must provide a model before being able to select views");

				return;
			}

			bool view_not_found = list_model_foreach<View> (this.model, (item, index) => {
				if (item == this._selected_view) {
					Gtk.ListBoxRow? row = this._list_box.get_row_at_index ((int) index);
					this._list_box.select_row (row);

					return false;
				}

				return true;
			});

			if (view_not_found) {
				warning ("The view to select must be part of the model");

				return;
			}

			this._selected_view = value;
		}
	}

	[GtkCallback (name = "update-selected-view")]
	private void update_selected_view (Gtk.ListBoxRow? row) {
		assert (row != null);
		var sidebar_row = (NavigationSidebarRow) row;
		this.selected_view = sidebar_row.view;
	}

	construct {
		this._list_box.set_header_func ((row, before) => {
			if (before == null) {
				return;
			}

			assert (row is NavigationSidebarRow && before is NavigationSidebarRow);

			var sidebar_row = (NavigationSidebarRow) row;
			var sidebar_before = (NavigationSidebarRow) before;

			assert (sidebar_row.view != null && sidebar_before.view != null);

			if (sidebar_row.view.category != sidebar_before.view.category) {
				row.set_header (new Gtk.Separator (Gtk.Orientation.HORIZONTAL) {
					css_classes = { "sidebar" }
				});
			}
		});
	}

	static construct {
		set_css_name ("navigationsidebar");
	}
}
