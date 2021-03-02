/* navigation-view.vala
 *
 * Copyright 2021 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
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
[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/navigator.ui")]
public class Rpy.Navigator : Gtk.Widget {
	private Gtk.SelectionModel _views;

	/**
	 *
	 */
	[GtkChild]
	[Description (nick = "Stack", blurb = "")]
	public unowned Gtk.Stack stack { get; }

	/**
	 *
	 */
	[Description (nick = "Views", blurb = "")]
	public Gtk.SelectionModel? views {
		get { return this._views; }
		set {
			if (value == this._views) {
				return;
			}

			if (this._views != null) {
				this._views.items_changed.disconnect (this.update_stack_pages);

				list_model_foreach<Gtk.StackPage> (this.stack.pages, page => {
					this.stack.remove (page.child);

					return true;
				});
			}

			this._views = value;

			if (this._views != null) {
				this._views.items_changed.connect (this.update_stack_pages);

				list_model_foreach<View> (this._views, view => {
					if (view.category == ViewCategory.SECONDARY) {
						return true;
					}

					Gtk.StackPage page = this.stack.add_child (view);
					view.bind_property ("icon-name", page, "icon-name", BindingFlags.DEFAULT | BindingFlags.SYNC_CREATE);
					view.bind_property ("title", page, "title", BindingFlags.DEFAULT | BindingFlags.SYNC_CREATE);

					return true;
				});
			}
		}
	}

	private void update_stack_pages (ListModel sender, uint position, uint removed, uint added) {
		if (removed != 0) {
			var to_remove = new GenericArray<Gtk.StackPage> ();

			list_model_foreach<Gtk.StackPage> (this.stack.pages, (page, index) => {
				if (index < position) {
					return true;
				}

				if (index < position + removed) {
					to_remove.add (page);
				}

				return false;
			});

			to_remove.@foreach (page => {
				this.stack.remove (page.child);
			});
		}

		if (added != 0) {
			list_model_foreach<View> (sender, (view, index) => {
				if (index < position) {
					return true;
				}

				if (index < position + added) {
					if (view.category == ViewCategory.SECONDARY) {
						return true;
					}

					Gtk.StackPage page = this.stack.add_child (view);
					view.bind_property ("icon-name", page, "icon-name", BindingFlags.DEFAULT | BindingFlags.SYNC_CREATE);
					view.bind_property ("title", page, "title", BindingFlags.DEFAULT | BindingFlags.SYNC_CREATE);

					return true;
				}

				return false;
			});
		}
	}
}
