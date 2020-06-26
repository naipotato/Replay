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
class ThemesService : Object {

    private Gtk.Settings _gtk_settings;
    private Gtk.CssProvider _light_css;
    private Gtk.CssProvider _dark_css;

    construct {
        this._gtk_settings = Gtk.Settings.get_default ();
        this._light_css = new Gtk.CssProvider ();
        this._dark_css = new Gtk.CssProvider ();

        // Load the css respectively
        this._light_css.load_from_resource (@"$(Constants.RESOURCE_PATH)/styles.css");
        this._dark_css.load_from_resource (@"$(Constants.RESOURCE_PATH)/styles-dark.css");
    }

    public void update_theme (bool dark_theme) {
        this._gtk_settings.gtk_application_prefer_dark_theme = dark_theme;

        // If dark theme is selected, remove light css and apply dark css, if light theme is
        // selected, remove dark css and apply light css
        Gtk.StyleContext.remove_provider_for_screen (Gdk.Screen.get_default (), dark_theme ?
            this._light_css : this._dark_css);
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), dark_theme ?
            this._dark_css : this._light_css, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
    }
}
