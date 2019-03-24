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

[GtkTemplate (ui = "/com/nucleuxsoft/UniTube/ui/main-window.ui")]
class UniTube.MainWindow : Gtk.ApplicationWindow {

	private uint configure_id;

	[GtkChild]
	private HeaderBar header_bar;

	public MainWindow (Gtk.Application app) {
		Object (
			application: app
		);
	}

	public override bool configure_event (Gdk.EventConfigure event) {
		if (configure_id != 0) {
			Source.remove (configure_id);
		}

		configure_id = Timeout.add (100, () => {
			configure_id = 0;

			if (this.is_maximized) {
				App.settings.set_boolean ("window-maximized", true);
			} else {
				App.settings.set_boolean ("window-maximized", false);

				Gdk.Rectangle rect;
				this.get_allocation (out rect);
				App.settings.set ("window-size", "(ii)", rect.width, rect.height);

				int root_x, root_y;
				this.get_position (out root_x, out root_y);
				App.settings.set ("window-position", "(ii)", root_x, root_y);
			}

			return false;
		});

		return base.configure_event (event);
	}
}
