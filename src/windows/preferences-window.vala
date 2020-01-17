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

using Hdy;

namespace Unitube {

    [GtkTemplate (ui = "/com/gitlab/nahuelwexd/Unitube/ui/preferences-window.ui")]
    public class PreferencesWindow : Hdy.PreferencesWindow {

        [GtkChild]
        private ComboRow theme_row;

        construct {
            this.theme_row.set_for_enum (typeof (ElementTheme), (value) => {
                switch (value.get_value ()) {
                    case ElementTheme.SYSTEM:
                        return "System";
                    case ElementTheme.LIGHT:
                        return "Light";
                    case ElementTheme.DARK:
                        return "Dark";
                    default:
                        return "";
                }
            });

            this.theme_row.selected_index =
                SettingsService.get_default ().appearance.app_theme;

            this.theme_row.notify["selected-index"].connect (() => {
                SettingsService.get_default ().appearance.app_theme =
                    (ElementTheme) this.theme_row.selected_index;
            });
        }
    }
}
