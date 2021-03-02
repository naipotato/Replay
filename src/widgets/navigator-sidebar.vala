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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/navigator-sidebar-row.ui")]
private class Rpy.NavigatorSidebarRow : Gtk.ListBoxRow {
	public View? view { get; construct; }

	public NavigatorSidebarRow (View view) {
		Object (
			view: view
		);
	}
}

/**
 * A navigation sidebar for {@link Navigator}.
 */
[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/navigator-sidebar.ui")]
public class Rpy.NavigatorSidebar : Gtk.Widget {
	private Navigator? _navigator;
	private Gtk.SelectionModel? _navigator_views;

	[GtkChild (name = "list-box")]
	private unowned Gtk.ListBox _list_box;

	[GtkChild (name = "list-model")]
	private unowned Gtk.SortListModel _list_model;

	[GtkChild (name = "list-model-sorter")]
	private unowned Gtk.CustomSorter _list_model_sorter;

	/**
	 *
	 */
	[Description (nick = "Navigator", blurb = "")]
	public Navigator? navigator {
		get { return this._navigator; }
		set {
			if (value == this._navigator) {
				return;
			}

			if (this._navigator != null) {
				this._navigator.notify["views"].disconnect (this.update_private_views_reference);
			}

			this._navigator = value;

			if (this._navigator != null) {
				this._navigator.notify["views"].connect (this.update_private_views_reference);
				this.update_private_views_reference ();
			}
		}
	}

	private void update_private_views_reference () requires (this.navigator != null) {
		if (this._navigator_views != null) {
			this._navigator.views.selection_changed.disconnect (this.update_selected_item);
		}

		this._navigator_views = this.navigator.views;

		if (this._navigator_views != null) {
			this._navigator_views.selection_changed.connect (this.update_selected_item);
		}
	}

	private void update_selected_item (Gtk.SelectionModel sender, uint position, uint n_items) {
		if (!sender.is_selected (position)) {
			return;
		}

		Gtk.ListBoxRow? row_selected = this._list_box.get_row_at_index ((int) position);
		this._list_box.select_row (row_selected);
	}

	[GtkCallback (name = "update-selected-view")]
	private void update_selected_view (Gtk.ListBoxRow? row) requires (this.navigator != null) {
		if (row == null) {
			return;
		}

		// Due to the fact that the views of the navigator are binded to the list
		// box, we can assume that the items are in the same order
		this.navigator.views.select_item (row.get_index (), true);
	}

	construct {
		this._list_model_sorter.set_sort_func ((a, b) => {
			var view_a = a as View;
			return_val_if_fail (view_a != null, 0);

			var view_b = b as View;
			return_val_if_fail (view_b != null, 0);

			if (view_a.category == view_b.category) {
				return 0;
			}

			if (view_a.category == ViewCategory.PRIMARY) {
				return -1;
			}

			if (view_b.category == ViewCategory.PRIMARY) {
				return 1;
			}
		});

		this._list_box.bind_model (this._list_model, item => {
			return_val_if_fail (item is View, null);
			return new NavigatorSidebarRow ((View) item);
		});

		this._list_box.set_header_func ((row, before) => {
			if (before == null) {
				return;
			}

			var sidebar_row = row as NavigatorSidebarRow;
			return_if_fail (sidebar_row != null);

			var sidebar_before = before as NavigatorSidebarRow;
			return_if_fail (sidebar_before != null);

			return_if_fail (sidebar_row.view != null);
			return_if_fail (sidebar_before.view != null);

			if (sidebar_row.view.category != sidebar_before.view.category) {
				sidebar_row.set_header (new Gtk.Separator (Gtk.Orientation.HORIZONTAL) {
					css_classes = { "sidebar" }
				});
			}
		});
	}

	static construct {
		set_css_name ("navigatorsidebar");
	}
}
