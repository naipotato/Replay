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

    public App (string app_id) {
        Object (
            application_id: app_id,
            flags: ApplicationFlags.FLAGS_NONE
        );
	}

	public override void activate () {
		// Get the actual window.
		var win = this.active_window;

		// If there's no window, then create a new one.
		if (win == null) {
			win = new MainWindow (this);
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

		base.startup ();
	}
}
