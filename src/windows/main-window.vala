/* Unitube GTK - An open source YouTube client written in Vala and GTK.
 * Copyright (C) 2019 - 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
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

using Gdk;
using Hdy;

namespace Unitube {

    [GtkTemplate (ui = "/com/github/nahuelwexd/UniTube/ui/main-window.ui")]
    public class MainWindow : ApplicationWindow {

        [GtkChild]
        private MainHeaderBar headerbar;

        [GtkChild]
        private TrendingView trending_view;

        [GtkChild]
        private SubscriptionsView subs_view;

        [GtkChild]
        private LibraryView library_view;

        public MainWindow (App app) {
            Object (
                application: app
            );

            var close_action = new SimpleAction ("close", null);
            close_action.activate.connect (this.close);
            app.set_accels_for_action ("win.close", {"<Primary>W"});
            this.add_action (close_action);

#if DEVEL
            var style_context = this.get_style_context ();
            style_context.add_class ("devel");
#endif
        }

        [GtkCallback]
        private bool on_key_press_event (EventKey event) {
            return headerbar.handle_event (event);
        }
    }
}
