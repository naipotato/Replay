/* Unitube GTK - An open source YouTube client written in Vala and GTK.
 * Copyright (C) 2019 - 2020 Nahuel Gomez Castro
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
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

using Gdk;
using Gtk;

namespace Unitube {

    public class App : Gtk.Application {

        public bool are_custom_styles_enabled {
            get {
                var gtk_settings = Gtk.Settings.get_default ();
                return gtk_settings.gtk_theme_name == "Adwaita" ||
                    gtk_settings.gtk_theme_name == "Adwaita-dark";
            }
        }

        public App () {
            Object (
                application_id: APPLICATION_ID,
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        private static int main (string[] args) {
            Hdy.init (ref args);

            var app = new Unitube.App ();
            return app.run (args);
        }

        protected override void startup () {
            base.startup ();

            this.populate_actions ();

            SettingsService.get_default ();

            IconTheme.get_default ().add_resource_path (@"$RESOURCE_PATH/icons");

            var provider = new CssProvider ();
            provider.load_from_resource (@"$RESOURCE_PATH/style.css");
            StyleContext.add_provider_for_screen (Screen.get_default (), provider,
                STYLE_PROVIDER_PRIORITY_APPLICATION);

            var gtk_settings = Gtk.Settings.get_default ();
            gtk_settings.notify["gtk-theme-name"].connect (() => {
                this.notify_property ("are-custom-styles-enabled");
            });
        }

        protected override void activate () {
            var win = this.active_window;

            if (win == null) {
                win = new MainWindow (this);
                win.show ();
            }

            win.present ();
        }

        private void populate_actions () {
            var action = new SimpleAction ("preferences", null);
            action.activate.connect (on_preferences_activate);
            this.add_action (action);

            action = new SimpleAction ("about", null);
            action.activate.connect (on_about_activate);
            this.add_action (action);

            action = new SimpleAction ("quit", null);
            action.activate.connect (this.quit);
            this.set_accels_for_action ("app.quit", {"<Ctrl>Q"});
            this.add_action (action);
        }

        private void on_preferences_activate () {
            var preferences_window = new PreferencesWindow () {
                transient_for = this.active_window
            };

            preferences_window.present ();
        }

        private void on_about_activate () {
            var about_dialog = new Unitube.AboutDialog () {
                transient_for = this.active_window
            };

            about_dialog.present ();
        }
    }
}
