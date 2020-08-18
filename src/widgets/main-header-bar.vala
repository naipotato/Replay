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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/main-header-bar.ui")]
class MainHeaderBar : Gtk.Widget {

    [GtkChild] private Gtk.HeaderBar _headerbar;
    [GtkChild] private Gtk.MenuButton _menu_button;
    private bool _menu_opened;

    static construct {
        set_layout_manager_type (typeof (Gtk.BinLayout));
    }

    [Signal (action = true)]
    public virtual signal void toggle_menu () {
        if (this._menu_opened) {
            this._menu_button.popdown ();
        } else {
            this._menu_button.popup ();
        }
    }

    public override void dispose () {
        this._headerbar.unparent ();
        base.dispose ();
    }
}
