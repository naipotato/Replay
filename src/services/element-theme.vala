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

namespace Unitube {

    public enum ElementTheme {
        SYSTEM, LIGHT, DARK;

        public static bool try_parse_nick (string nick, out ElementTheme result = null) {
            // Based on example provided by Valadoc on
            // https://valadoc.org/gobject-2.0/GLib.EnumValue.html

            EnumClass enumc = (EnumClass) typeof (ElementTheme).class_ref ();

            unowned EnumValue? eval = enumc.get_value_by_nick (nick);
            if (eval == null) {
                result = ElementTheme.SYSTEM;
                return false;
            }

            result = (ElementTheme) eval.value;
            return true;
        }

        public string to_nick () {
            // Based on example provided by Valadoc on
            // https://valadoc.org/gobject-2.0/GLib.EnumValue.html

            EnumClass enumc = (EnumClass) typeof (ElementTheme).class_ref ();
            unowned EnumValue? eval = enumc.get_value (this);
            return_val_if_fail (eval != null, null);
            return eval.value_nick;
        }
    }
}
