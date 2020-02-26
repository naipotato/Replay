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

namespace Unitube {

    public class AppearanceSettings : Object {

        private bool _dark_theme;

        public bool use_system_theme { get; set; }

        public bool dark_theme {
            get {
                return this._dark_theme;
            }
            set {
                var gtk_settings = Gtk.Settings.get_default ();
                gtk_settings.gtk_application_prefer_dark_theme = _dark_theme = value;
                message (@"$value");
            }
        }

        public AppearanceSettings (string schema) {
            var gtk_settings = Gtk.Settings.get_default ();
            var settings = new Settings (schema);

            if (gtk_settings.gtk_application_prefer_dark_theme) {
                this.use_system_theme = true;
            }

            settings.bind ("dark-theme", this, "dark-theme",
                SettingsBindFlags.DEFAULT);
        }
    }
}
