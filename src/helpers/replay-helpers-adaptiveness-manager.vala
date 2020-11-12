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

public enum Replay.Helpers.AdaptiveStates
{
    EXTRA_SMALL,
    SMALL,
    MEDIUM,
    LARGE,
    EXTRA_LARGE;
}

public class Replay.Helpers.AdaptivenessManager : GLib.Object
{
    private AdaptiveStates _current_state;


    public signal void state_changed (AdaptiveStates new_state);


    public void inform_new_width (int new_width)
    {
        AdaptiveStates new_state;

        if (new_width < 576) {
            new_state = AdaptiveStates.EXTRA_SMALL;
        } else if (576 <= new_width < 768) {
            new_state = AdaptiveStates.SMALL;
        } else if (768 <= new_width < 992) {
            new_state = AdaptiveStates.MEDIUM;
        } else if (992 <= new_width < 1200) {
            new_state = AdaptiveStates.LARGE;
        } else {
            new_state = AdaptiveStates.EXTRA_LARGE;
        }

        if (new_state != this._current_state) {
            this._current_state = new_state;
            this.state_changed (new_state);
        }
    }
}
