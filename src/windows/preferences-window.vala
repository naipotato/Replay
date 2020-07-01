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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/preferences-window.ui")]
class PreferencesWindow : Hdy.PreferencesWindow {

    private PreferencesViewModel _view_model;
    [GtkChild] private Hdy.ActionRow _switch_row;
    [GtkChild] private Gtk.Switch _toggle;

    construct {
        this._view_model = new PreferencesViewModel ();

        this._switch_row.activatable_widget = this._toggle;
        this.icon_name = Constants.APPLICATION_ID;

        this._view_model.bind_property ("dark-theme", this._toggle, "active",
            BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL);
    }
}
