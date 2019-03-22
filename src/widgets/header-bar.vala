/* Copyright (C) 2019 Nucleux Software
 *
 * This file is part of unitube-gtk.
 *
 * unitube-gtk is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * unitube-gtk is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY of FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with unitube-gtk.  If not, see <https://www.gnu.org/licenses/>.
 *
 * Author: Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 */

[GtkTemplate (ui = "/com/nucleuxsoft/UniTube/ui/header-bar.ui")]
class UniTube.HeaderBar : Gtk.HeaderBar {

	private bool _selection_mode;

	[GtkChild]
	private Gtk.Button back_button;

	[GtkChild]
	private Gtk.ToggleButton select_button;

	[GtkChild]
	private Gtk.ToggleButton search_button;

	[GtkChild]
	private Gtk.Button cancel_button;

	[GtkChild]
	private Gtk.MenuButton menu_button;

	construct {
		/* Initialize fields */
		this._selection_mode = false;

		/* Bind properties */
		this.bind_property ("selection-mode", this, "show-close-button",
			BindingFlags.SYNC_CREATE | BindingFlags.INVERT_BOOLEAN);
		this.bind_property ("selection-mode", this.select_button, "active",
			BindingFlags.BIDIRECTIONAL);
		this.bind_property ("selection-mode", this.cancel_button, "visible");
		this.bind_property ("selection-mode", this.select_button, "visible",
			BindingFlags.INVERT_BOOLEAN);
		this.bind_property ("selection-mode", this.menu_button, "visible",
			BindingFlags.INVERT_BOOLEAN);
		this.bind_property ("selection-mode", this.back_button, "visible",
			BindingFlags.INVERT_BOOLEAN);
		this.bind_property ("search-mode", this.search_button, "active",
			BindingFlags.BIDIRECTIONAL);
	}

	public bool selection_mode {
		get {
			return this._selection_mode;
		}
		set {
			this._selection_mode = value;

			if (value) {
				this.get_style_context ().add_class ("selection-mode");
			} else {
				this.get_style_context ().remove_class ("selection-mode");
			}
		}
	}

	public bool search_mode { get; set; }

	public signal void back_requested ();

	[GtkCallback]
	private void on_back_button_clicked () {
		this.back_requested ();
	}

	[GtkCallback]
	private void on_cancel_button_clicked () {
		this.selection_mode = false;
	}
}
