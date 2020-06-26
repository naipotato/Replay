/* Replay - An open source YouTube client for GNOME
 * Copyright (C) 2019 - 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * Replay is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Replay is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Replay.  If not, see <https://www.gnu.org/licenses/>.
 */

[SingleInstance]
class Replay.SettingsService : Object {

    private bool _dark_theme;

    public bool dark_theme {
        get {
            return this._dark_theme;
        }
        set {
            var gtk_settings = Gtk.Settings.get_default ();
            gtk_settings.gtk_application_prefer_dark_theme = _dark_theme = value;
        }
    }

    construct {
        var settings = new Settings (@"$(Constants.RDNN_APP_NAME)");
        settings.bind ("dark-theme", this, "dark-theme", SettingsBindFlags.DEFAULT);
    }
}
