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

class UniTube.App : Gtk.Application {

	public static Settings settings;

    public App (string app_id) {
        Object (
            application_id: app_id,
            flags: ApplicationFlags.FLAGS_NONE
        );
	}

	static construct {
		settings = new Settings ("com.nucleuxsoft.UniTube");
	}

	public override void activate () {
		// Get the actual window.
		var win = this.active_window;

		if (win == null) {
			// If there's no window, then create a new one.
			win = new MainWindow (this);

			int window_x, window_y;
			var rect = Gtk.Allocation ();

			App.settings.get ("window-position", "(ii)", out window_x, out window_y);
			App.settings.get ("window-size", "(ii)", out rect.width, out rect.height);

			if (window_x != -1 || window_y != -1) {
				win.move (window_x, window_y);
			}

			win.set_allocation (rect);

			if (App.settings.get_boolean ("window-maximized")) {
				win.maximize ();
			}

			win.show_all ();
		}

		// Ensure that the window is on foreground.
		win.present ();
	}

	public override void startup () {
		// Add quit accelerator
		var action = new SimpleAction ("quit", null);
		action.activate.connect (this.quit);
		this.add_action (action);
		this.set_accels_for_action ("app.quit", { "<Ctrl>Q" });

		// Add about action
		action = new SimpleAction ("about", null);
		action.activate.connect (this.on_about_activate);
		this.add_action (action);

		base.startup ();
	}

	private void on_about_activate () {
		var about_dialog = new AboutDialog ();
		about_dialog.transient_for = this.active_window;
		about_dialog.present ();
	}
}
