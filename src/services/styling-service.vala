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

using Gtk;
using Gdk;

namespace Unitube {

    public class StylingService : Object {

        private static Once<StylingService> instance;

        private CssProvider dark_css;
        private CssProvider light_css;

        private StylingService () {
            this.dark_css = new CssProvider ();
            this.light_css = new CssProvider ();

            // Load css respectively
            this.dark_css.load_from_resource (@"$RESOURCE_PATH/styles-dark.css");
            this.light_css.load_from_resource (@"$RESOURCE_PATH/styles.css");

            // Connect signals
            var gtk_settings = Gtk.Settings.get_default ();
            gtk_settings.notify["gtk-theme-name"].connect (on_theme_changed);
            gtk_settings.notify["gtk-application-prefer-dark-theme"].connect (on_theme_changed);

            // Emit signals
            gtk_settings.notify_property ("gtk-theme-name");
            gtk_settings.notify_property ("gtk-application-prefer-dark-theme");
        }

        public static void init () {
            instance.once (() => {
                return new StylingService ();
            });
        }

        private void switch_to_light_css () {
            StyleContext.remove_provider_for_screen (Screen.get_default (),
                this.dark_css);
            StyleContext.add_provider_for_screen (Screen.get_default (),
                this.light_css, STYLE_PROVIDER_PRIORITY_APPLICATION);
        }

        private void switch_to_dark_css () {
            StyleContext.remove_provider_for_screen (Screen.get_default (),
                this.light_css);
            StyleContext.add_provider_for_screen (Screen.get_default (),
                this.dark_css, STYLE_PROVIDER_PRIORITY_APPLICATION);
        }

        private void remove_all_css () {
            StyleContext.remove_provider_for_screen (Screen.get_default (),
                this.light_css);
            StyleContext.remove_provider_for_screen (Screen.get_default (),
                this.dark_css);
        }

        private void on_theme_changed () {
            var gtk_settings = Gtk.Settings.get_default ();

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
}
