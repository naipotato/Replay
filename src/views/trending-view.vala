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

using Gtk;

namespace Unitube {

    [GtkTemplate (ui = "/com/github/nahuelwexd/UniTube/ui/trending-view.ui")]
    public class TrendingView : Bin {

        private TrendingViewModel view_model;

        [GtkChild]
        private Stack placeholder_stack;

        [GtkChild]
        private CheckButton button;

        construct {
            this.view_model = new TrendingViewModel ();

            this.view_model.notify["is-loading"].connect (() => {
                if (this.view_model.is_loading) {
                    this.placeholder_stack.visible_child_name = "loading";
                } else {
                    this.placeholder_stack.visible_child_name = "failed";
                }
            });

            this.view_model.notify_property ("is-loading");

            button.bind_property ("active", this.view_model, "is-loading");
        }
    }
}
