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
        base.activate ();

        if (this.active_window == null) {
            // If there's no active window, let's create a new one
            var window = new MainWindow (this);

            // Load preferences about the window
            this.load_preferences (window);

            // Show the window created
            window.show_all ();
        }

        // Ensure that the active window is on foreground
        this.active_window.present ();
    }

    public override void startup () {
        base.startup ();

        // Add quit action
        var action = new SimpleAction ("quit", null);
        action.activate.connect (this.quit);
        this.add_action (action);
        this.set_accels_for_action ("app.quit", { "<Ctrl>Q" });

        // Add about action
        action = new SimpleAction ("about", null);
        action.activate.connect (this.on_about_activate);
        this.add_action (action);

        // Add dark theme action
        var settings = SettingsService.instance;
        var variant = new Variant.boolean (settings.dark_theme);
        action = new SimpleAction.stateful ("dark-theme", null, variant);
        action.change_state.connect (this.on_dark_theme_change_state);
        this.add_action (action);
    }

    private void load_preferences (Gtk.Window window) {
        var settings = SettingsService.instance;

        // Load window position
        var position = settings.window_position;
        if (position.x != -1 || position.y != -1) {
            window.move (position.x, position.y);
        }

        // Load window size
        window.set_allocation (settings.window_size);

        // Load a value that indicates whether the window is maximized or not
        if (settings.window_maximized) {
            window.maximize ();
        }

        // Load a value that indicates whether the dark theme is enabled or not
        var gtk_settings = Gtk.Settings.get_default ();
        gtk_settings.gtk_application_prefer_dark_theme = settings.dark_theme;
    }

    private void on_about_activate () {
        var about_dialog = new AboutDialog (this.active_window);
        about_dialog.present ();
    }

    private void on_dark_theme_change_state (SimpleAction sender, Variant? value) {
        assert (value != null);
        sender.set_state (value);

        var gtk_settings = Gtk.Settings.get_default ();
        gtk_settings.gtk_application_prefer_dark_theme = value.get_boolean ();

        SettingsService.instance.dark_theme = value.get_boolean ();
    }
}
