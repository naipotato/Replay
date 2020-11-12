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

int main (string[] args)
{
    GLib.Intl.setlocale (LocaleCategory.ALL);
    GLib.Intl.bindtextdomain (Replay.Constants.GETTEXT_PACKAGE, Replay.Constants.LOCALEDIR);
    GLib.Intl.bind_textdomain_codeset (Replay.Constants.GETTEXT_PACKAGE, "UTF-8");
    GLib.Intl.textdomain (Replay.Constants.GETTEXT_PACKAGE);

    return new Replay.App ().run (args);
}
