/* application-window.vala
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
 *
 */
[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/application-window.ui")]
public class Rpy.ApplicationWindow : Adw.ApplicationWindow {
	private NavigationService? _navigation_service;

	[GtkChild (name = "content-leaflet")]
	private unowned Adw.Leaflet _content_leaflet;

	[GtkChild (name = "sidebar-header-bar")]
	private unowned HeaderBar _sidebar_header_bar;

	/**
	 *
	 */
	public NavigationService? navigation_service {
		get { return this._navigation_service; }
		construct {
			if (value == null) {
				return;
			}

			this._navigation_service = value;

			this._navigation_service.go_back.connect (this.go_back);
			this._navigation_service.navigation_requested.connect (this.navigate_to);
		}
	}

	/**
	 *
	 */
	public ListModel views { get; construct; }

	/**
	 *
	 */
	public ApplicationWindow (Application app, NavigationService nav_service, ListModel views) {
		Object (
			application: app,
			navigation_service: nav_service,
			views: views
		);
	}

	private void go_back () {
		this._content_leaflet.navigate (Adw.NavigationDirection.BACK);
	}

	private void navigate_to (Page page) {
		if (page.get_parent () != this._content_leaflet) {
			this._content_leaflet.append (page);
		}

		this._content_leaflet.visible_child = page;
	}

	[GtkCallback (name = "try-remove-page")]
	private void try_remove_page () {
		if (this._content_leaflet.child_transition_running) {
			return;
		}

		Gtk.Widget? child = this._content_leaflet.get_first_child ();
		while (child != null) {
			Gtk.Widget page = child;
			child = child.get_next_sibling ();

			if (page == this._content_leaflet.visible_child) {
				break;
			}

			this._content_leaflet.remove (page);
		}
	}

	construct {
		this._sidebar_header_bar.title = Environment.get_application_name ();

#if DEVEL
		this.add_css_class ("devel");
#endif
	}
}
