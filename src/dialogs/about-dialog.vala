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

namespace Unitube {

    [GtkTemplate (ui = "/com/gitlab/nahuelwexd/Unitube/ui/about-dialog.ui")]
    public class AboutDialog : Gtk.AboutDialog {

        construct {
            this.logo_icon_name = Config.APP_ID;
            this.version = Config.VERSION;
            this.website = Config.PACKAGE_URL;
        }

        [GtkCallback]
        private void on_response (int response_id) {
            if (response_id == ResponseType.CANCEL ||
                response_id == ResponseType.DELETE_EVENT) {
                this.hide_on_delete ();
            }
        }
    }
}
