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
using Gtk;

namespace Unitube {

    [GtkTemplate (ui = "/com/gitlab/nahuelwexd/Unitube/ui/preferences-window.ui")]
    public class PreferencesWindow : Hdy.PreferencesWindow {

        [GtkChild]
        private ActionRow switch_row;

        [GtkChild]
        private Switch toggle;

        construct {
            this.switch_row.activatable_widget = this.toggle;

            var settings = SettingsService.get_default ();
            settings.bind_property ("dark-theme", toggle, "active",
                BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL);
        }
    }
}
