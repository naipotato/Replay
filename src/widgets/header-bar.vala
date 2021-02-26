/* header-bar.vala
 *
 * Copyright 2019-2021 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
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
 * A header bar with ready-made features: back button, search button, menu
 * button, and integrated search bar.
 *
 * The menu button is associated with a ready-made menu model that has 3 items:
 *  * Preferences (win.show-preferences)
 *  * Keyboard shortcuts (win.show-help-overlay)
 *  * About Replay (win.show-about)
 */
[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/header-bar.ui")]
public class Rpy.HeaderBar : Gtk.Widget {
	private unowned Gtk.Widget? _key_capture_widget;
	private bool _search_mode;
	private bool _show_back_button;
	private bool _show_search_button;

	[GtkChild (name = "back-button-revealer")]
	private unowned Gtk.Revealer _back_button_revealer;

	[GtkChild (name = "header-bar")]
	private unowned Adw.HeaderBar _header_bar;

	[GtkChild (name = "search-bar")]
	private unowned Gtk.SearchBar _search_bar;

	/**
	 * The widget from which the key events will be captured to display the
	 * search entry. Required for the "type to search" feature.
	 *
	 * Note: If {@link show_back_button} is ``false``, this property will
	 * return ``null`` even if it actually has a value.
	 */
	[Description (nick = "Key Capture Widget", blurb = "The widget from which to capture key events")]
	public unowned Gtk.Widget? key_capture_widget {
		get { return this.show_search_button ? this._key_capture_widget : null; }
		set {
			if (value == this._key_capture_widget) {
				return;
			}

			this._key_capture_widget = value;
		}
	}

	/**
	 * The search entry within the search bar built into the header bar.
	 */
	[GtkChild (name = "search-entry")]
	[Description (nick = "Search Entry", blurb = "The search entry built into the header bar")]
	public unowned Gtk.SearchEntry search_entry { get; }

	/**
	 * Whether the search mode is on and the search bar shown.
	 *
	 * In order to alter the value of this property, the value of
	 * {@link show_search_button} must be ``true``, otherwise the values
	 * entered will be ignored.
	 */
	[Description (nick = "Search Mode", blurb = "The status of the search mode")]
	public bool search_mode {
		get { return this._search_mode; }
		set {
			if (value == this._search_mode || !this.show_search_button && !this._search_mode) {
				return;
			}

			this._search_mode = value;
		}
	}

	/**
	 * Whether to show or not the back button.
	 */
	[Description (nick = "Show Back Button", blurb = "Whether the back button is shown or not")]
	public bool show_back_button {
		get { return this._show_back_button; }
		set {
			if (value == this._show_back_button) {
				return;
			}

			this._show_back_button = value;

			this.update_back_button_visibility ();
		}
	}

	/**
	 * Whether to show the title buttons at the end of the header bar, like
	 * close, minimize, maximize.
	 */
	[Description (nick = "Show End Title Buttons", blurb = "Whether title buttons at the end of the header bar are shown or not")]
	public bool show_end_title_buttons { get; set; default = true; }

	/**
	 * Whether to show the menu button.
	 */
	[Description (nick = "Show Menu Button", blurb = "Whether the menu button is shown or not")]
	public bool show_menu_button { get; set; }

	/**
	 * Whether to show the search button.
	 */
	[Description (nick = "Show Search Button", blurb = "Whether the search button is shown or not")]
	public bool show_search_button {
		get { return this._show_search_button; }
		set {
			if (value == this._show_search_button) {
				return;
			}

			this._show_search_button = value;

			// If the search button is hidden, we also turn off the search mode
			if (!this._show_search_button) {
				this.search_mode = false;
			}

			// The getter of key-capture-widget depends on the value of this
			// property, so if this property changes its value, we must also
			// notify in key-capture-widget
			this.notify_property ("key-capture-widget");
		}
	}

	/**
	 * Whether to show the title buttons at the start of the header bar, like
	 * close, minimize, maximize.
	 */
	[Description (nick = "Show Start Title Buttons", blurb = "Whether title buttons at the start of the header bar are shown or not")]
	public bool show_start_title_buttons { get; set; default = true; }

	/**
	 * The subtitle to be displayed.
	 */
	[Description (nick = "Subtitle", blurb = "The subtitle to be displayed")]
	public string? subtitle { get; set; }

	/**
	 * The title to be displayed.
	 */
	[Description (nick = "Title", blurb = "The title to be displayed")]
	public string? title { get; set; }

	protected override void dispose () {
		this._header_bar.unparent ();
		this._search_bar.unparent ();

		base.dispose ();
	}

	// Because the GtkBox inside the start of the header bar applies the
	// spacing even to revealers' hidden children, we need to touch the
	// visibility of the back button revealer to prevent the search button from
	// getting misaligned when the back button is not being shown.
	[GtkCallback (name = "update-back-button-visibility")]
	private void update_back_button_visibility () {
		if (!this._back_button_revealer.child_revealed && !this.show_back_button) {
			this._back_button_revealer.visible = false;
		} else {
			this._back_button_revealer.visible = true;
		}
	}

	construct {
		this._search_bar.connect_entry (this.search_entry);
		this.update_back_button_visibility ();
	}
}
