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

    public class SystemSettings : Object {

        private Settings settings;
        private Gtk.Settings gtk_settings;

        public string gtk_theme { get; set; }

        private bool? _dark_theme;
        public bool dark_theme {
            get {
                _dark_theme = _dark_theme ?? gtk_settings.gtk_application_prefer_dark_theme;
                return _dark_theme;
            }
        }

        public SystemSettings (string schema) {
            settings = new Settings (schema);
            gtk_settings = Gtk.Settings.get_default ();

            settings.bind ("gtk-theme", this, "gtk-theme", SettingsBindFlags.GET);
        }
    }
}
