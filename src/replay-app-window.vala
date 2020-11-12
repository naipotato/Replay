/* Replay - An open source YouTube client for GNOME
 * Copyright 2019 - 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * Replay is free software: you can redistribute it and/or modify it under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * Replay is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Replay.  If not, see <https://www.gnu.org/licenses/>.
 */

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/app-window.ui")]
public class Replay.AppWindow : Hdy.ApplicationWindow
{
    [GtkChild] private Gtk.Stack _content_stack;
    [GtkChild] private Gtk.Revealer _revealer;


    public new Gtk.Application application
    {
        get { return base.application; }
        construct
        {
            if (base.application == value) return;
            base.application = value;
        }
    }

    public Helpers.AdaptivenessManager adaptiveness_manager { get; construct; }


    public override void size_allocate (int width, int height, int baseline)
    {
        base.size_allocate (width, height, baseline);
        this.adaptiveness_manager.inform_new_width (width);
    }


    private void on_adaptiveness_manager_state_changed (Helpers.AdaptiveStates new_state)
    {
        switch (new_state) {
        case Helpers.AdaptiveStates.EXTRA_SMALL:
            this._revealer.reveal_child = false;
            break;
        case Helpers.AdaptiveStates.SMALL:
        case Helpers.AdaptiveStates.MEDIUM:
        case Helpers.AdaptiveStates.LARGE:
        case Helpers.AdaptiveStates.EXTRA_LARGE:
            this._revealer.reveal_child = true;
            break;
        }
    }


    construct
    {
        this.adaptiveness_manager.state_changed.connect (this.on_adaptiveness_manager_state_changed);
    }
}
