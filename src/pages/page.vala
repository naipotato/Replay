/* page.vala
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
 * A base class for creating pages.
 *
 * This class integrates 2 convenient properties to display the title bar and
 * the content in their respective location, as well as integration with the
 * navigation service to be able to navigate from one page to another in a
 * simple way.
 *
 * = Rpy.Page as Gtk.Buildable =
 *
 * The {@link Page} implementation of the {@link Gtk.Buildable} interface
 * supports setting a child as the title bar by setting "titlebar" as the "type"
 * attribute of a ``<child>`` element. See {@link titlebar} for info.
 */
public abstract class Rpy.Page : Gtk.Widget, Gtk.Buildable {
	private Adw.Bin _child_bin;
	private Adw.Bin _titlebar_bin;

	/**
	 * The widget to be used as a child of this page.
	 */
	[Description (nick = "Child", blurb = "The child widget of this page")]
	public Gtk.Widget? child {
		get { return this._child_bin.child; }
		set { this._child_bin.child = value; }
	}

	/**
	 * The current navigation service of the app.
	 */
	[Description (nick = "Navigation Service", blurb = "The current navigation service of the app")]
	public NavigationService navigation_service { get; construct; }

	/**
	 * The widget that will be used as the title bar for this page.
	 *
	 * Typically a {@link HeaderBar} is used.
	 */
	[Description (nick = "Titlebar", blurb = "The widget used as the title bar of this page")]
	public Gtk.Widget? titlebar {
		get { return this._titlebar_bin.child; }
		set { this._titlebar_bin.child = value; }
	}

	protected void add_child (Gtk.Builder builder, Object child, string? type) {
		if (child is Gtk.Widget && type == "titlebar") {
			this.titlebar = (Gtk.Widget) child;
		} else if (child is Gtk.Widget) {
			this.child = (Gtk.Widget) child;
		} else {
			base.add_child (builder, child, type);
		}
	}

	protected override void dispose () {
		this._child_bin.unparent ();
		this._titlebar_bin.unparent ();

		base.dispose ();
	}

	/**
	 * It is called when a navigation has been made to the page.
	 *
	 * This method is typically overridden to perform page initialization
	 * operations. No chain-up is needed.
	 *
	 * @param parameter An optional parameter that was passed when the
	 *                  navigation was performed.
	 */
	public virtual void on_navigated_to (Value? parameter) { }

	construct {
		this.layout_manager = new Gtk.BoxLayout (Gtk.Orientation.VERTICAL);

		this._titlebar_bin = new Adw.Bin ();
		this._titlebar_bin.set_parent (this);

		this._child_bin = new Adw.Bin () {
			vexpand = true
		};

		this._child_bin.set_parent (this);
	}
}
