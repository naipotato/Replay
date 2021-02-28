/* view.vala
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
 * A base class for creating views.
 *
 * It contains the necessary properties to be able to show the views in a menu,
 * as well as to be able to categorize them.
 */
public abstract class Rpy.View : Gtk.Widget {
	private Gtk.Widget? _child;

	/**
	 * The category of the view.
	 */
	[Description (nick = "Category", blurb = "The category of the view")]
	public ViewCategory category { get; set; }

	/**
	 * The child widget of the view.
	 */
	[Description (nick = "Child", blurb = "The child widget of the view")]
	public Gtk.Widget? child {
		get { return this._child; }
		set {
			if (value == this._child) {
				return;
			}

			if (this._child != null) {
				this._child.unparent ();
			}

			this._child = value;

			if (this._child != null) {
				this._child.set_parent (this);
			}
		}
	}

	/**
	 * The name of the icon that will be displayed in the menus representing
	 * the view.
	 */
	[Description (nick = "Icon Name", blurb = "The name of the view icon")]
	public string? icon_name { get; set; }

	/**
	 * The title that will be displayed in the menus representing the view.
	 */
	[Description (nick = "Title", blurb = "The title of the view")]
	public string? title { get; set; }

	protected void add_child (Gtk.Builder builder, Object child, string? type) {
		if (child is Gtk.Widget) {
			this.child = (Gtk.Widget) child;
		} else {
			base.add_child (builder, child, type);
		}
	}

	protected override void dispose () {
		this.child = null;
		base.dispose ();
	}

	construct {
		this.layout_manager = new Gtk.BinLayout ();
	}
}
