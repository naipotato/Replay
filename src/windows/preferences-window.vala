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

using Hdy;
using Gtk;

namespace Replay {

    [GtkTemplate (ui = "/com/github/nahuelwexd/Replay/gtk/preferences-window.ui")]
    public class PreferencesWindow : Hdy.PreferencesWindow {

        [GtkChild]
        private ActionRow switch_row;

        [GtkChild]
        private Switch toggle;

        construct {
            this.switch_row.activatable_widget = this.toggle;

            var settings = SettingsService.get_default ();

            this.icon_name = APPLICATION_ID;

            settings.appearance.bind_property ("dark-theme", this.toggle, "active",
                BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL);
            settings.appearance.bind_property ("use-system-theme", this.switch_row,
                "sensitive", BindingFlags.SYNC_CREATE | BindingFlags.INVERT_BOOLEAN);
        }
    }
}
