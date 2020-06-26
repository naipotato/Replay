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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/gtk/main-header-bar.ui")]
class MainHeaderBar : Hdy.HeaderBar {

    [GtkChild] private Hdy.ViewSwitcherTitle _view_switcher_title;
    [GtkChild] private Gtk.ToggleButton _search_button;
    [GtkChild] private Gtk.MenuButton _menu_button;
    [GtkChild] private Gtk.SearchEntry _search_entry;
    [GtkChild] private Gtk.Stack _title_stack;

    public Gtk.Stack stack { get; set; }
    public bool is_narrow_mode { get; set; }
    public bool search_mode { get; set; }

    construct {
        this.bind_property ("stack", this._view_switcher_title, "stack", BindingFlags.BIDIRECTIONAL);
        this.bind_property ("search-mode", this._search_button, "active", BindingFlags.BIDIRECTIONAL);

        this._view_switcher_title.bind_property ("title-visible", this, "is-narrow-mode",
            BindingFlags.DEFAULT | BindingFlags.SYNC_CREATE);
    }

    [Signal (action = true)] public signal void toggle_menu ();
    [Signal (action = true)] public signal void toggle_search_mode ();

    public bool handle_event (Gdk.EventKey event) {
        if (this.search_mode) {
            return Gdk.EVENT_PROPAGATE;
        }

        var handled = this._search_entry.handle_event (event);
        if (handled == Gdk.EVENT_STOP) {
            this.search_mode = true;
        }

        return handled;
    }

    [GtkCallback]
    private void on_search_mode_toggled () {
        this.search_mode = !this.search_mode;
    }

    [GtkCallback]
    private void on_menu_toggled () {
        this._menu_button.active = !this._menu_button.active;
    }

    [GtkCallback]
    private void on_search_mode_changed () {
        if (this.search_mode) {
            this._title_stack.visible_child_name = "search";
            this._search_entry.grab_focus_without_selecting ();
            this._search_entry.move_cursor (Gtk.MovementStep.LOGICAL_POSITIONS, int.MAX, false);
        } else {
            this._title_stack.visible_child_name = "tabs";
            this._search_entry.text = "";
        }
    }

    [GtkCallback]
    private void on_search_entry_stop_search () {
        this.search_mode = false;
    }
}
