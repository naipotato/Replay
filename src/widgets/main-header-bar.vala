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
using Gdk;

namespace Unitube {

    [GtkTemplate (ui = "/com/github/nahuelwexd/UniTube/ui/main-header-bar.ui")]
    public class MainHeaderBar : Hdy.HeaderBar {

        [GtkChild]
        private ViewSwitcherTitle view_switcher_title;

        [GtkChild]
        private ToggleButton search_button;

        [GtkChild]
        private MenuButton menu_button;

        [GtkChild]
        private SearchEntry search_entry;

        [GtkChild]
        private Stack title_stack;

        public Gtk.Stack stack { get; set; }
        public bool is_narrow_mode { get; set; }
        public bool search_mode { get; set; }

        construct {
            bind_property ("stack", view_switcher_title, "stack",
                BindingFlags.BIDIRECTIONAL);
            bind_property ("search-mode", search_button, "active",
                BindingFlags.BIDIRECTIONAL);

            view_switcher_title.bind_property ("title-visible", this,
                "is-narrow-mode", BindingFlags.DEFAULT | BindingFlags.SYNC_CREATE);

            var app = (App) GLib.Application.get_default ();
        }

        [Signal (action = true)]
        public signal void toggle_menu ();

        [Signal (action = true)]
        public signal void toggle_search_mode ();

        public bool handle_event (EventKey event) {
            if (search_mode) {
                return EVENT_PROPAGATE;
            }

            var handled = search_entry.handle_event (event);
            if (handled == EVENT_STOP) {
                search_mode = true;
            }

            return handled;
        }

        [GtkCallback]
        private void on_search_mode_toggled () {
            search_mode = !search_mode;
        }

        [GtkCallback]
        private void on_menu_toggled () {
            menu_button.active = !menu_button.active;
        }

        [GtkCallback]
        private void on_search_mode_changed () {
            if (search_mode) {
                title_stack.visible_child_name = "search";
                search_entry.grab_focus_without_selecting ();
                search_entry.move_cursor (MovementStep.LOGICAL_POSITIONS, int.MAX,
                    false);
            } else {
                title_stack.visible_child_name = "tabs";
                search_entry.text = "";
            }
        }

        [GtkCallback]
        private void on_search_entry_stop_search () {
            search_mode = false;
        }
    }
}
