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

class Replay.StylingService : Object {

    private static Once<Replay.StylingService> _instance;

    private Gtk.CssProvider _dark_css;
    private Gtk.CssProvider _light_css;

    private StylingService () {
        this._dark_css = new Gtk.CssProvider ();
        this._light_css = new Gtk.CssProvider ();

        // Load css respectively
        this._dark_css.load_from_resource (@"$(Constants.RESOURCE_PATH)/styles-dark.css");
        this._light_css.load_from_resource (@"$(Constants.RESOURCE_PATH)/styles.css");

        // Connect signals
        var gtk_settings = Gtk.Settings.get_default ();
        gtk_settings.notify["gtk-theme-name"].connect (on_theme_changed);
        gtk_settings.notify["gtk-application-prefer-dark-theme"].connect (on_theme_changed);

        // Emit signals
        gtk_settings.notify_property ("gtk-theme-name");
        gtk_settings.notify_property ("gtk-application-prefer-dark-theme");
    }

    public static void init () {
        _instance.once (() => {
            return new StylingService ();
        });
    }

    private void switch_to_light_css () {
        Gtk.StyleContext.remove_provider_for_screen (Gdk.Screen.get_default (), this._dark_css);
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), this._light_css,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
    }

    private void switch_to_dark_css () {
        Gtk.StyleContext.remove_provider_for_screen (Gdk.Screen.get_default (), this._light_css);
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), this._dark_css,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
    }

    private void remove_all_css () {
        Gtk.StyleContext.remove_provider_for_screen (Gdk.Screen.get_default (), this._light_css);
        Gtk.StyleContext.remove_provider_for_screen (Gdk.Screen.get_default (), this._dark_css);
    }

    private void on_theme_changed () {
        var gtk_settings = Gtk.Settings.get_default ();

        var env_theme = Environment.get_variable ("GTK_THEME");
        if (env_theme != null && env_theme != "") {
            if (/^Adwaita[-:]dark$/.match (env_theme)) {
                this.switch_to_dark_css ();
            } else if (/^Adwaita(:.*|$)/.match (env_theme)) {
                this.switch_to_light_css ();
            } else {
                this.remove_all_css ();
            }

            return;
        }

        switch (gtk_settings.gtk_theme_name) {
            case "Adwaita":
                if (gtk_settings.gtk_application_prefer_dark_theme) {
                    this.switch_to_dark_css ();
                    break;
                }

                this.switch_to_light_css ();
                break;
            case "Adwaita-dark":
                this.switch_to_dark_css ();
                break;
            default:
                this.remove_all_css ();
                break;
        }
    }
}
