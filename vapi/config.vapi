/* Replay - An open source YouTube client for GNOME
 * Copyright (C) 2019 - 2020 Nahuel Gomez Castro
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

namespace Replay.Constants {

    [CCode (cheader_filename = "config.h", cname = "RDNN_APP_NAME")]
    public const string RDNN_APP_NAME;

    [CCode (cheader_filename = "config.h", cname = "APPLICATION_ID")]
    public const string APPLICATION_ID;

    [CCode (cheader_filename = "config.h", cname = "PACKAGE_URL")]
    public const string PACKAGE_URL;

    [CCode (cheader_filename = "config.h", cname = "RESOURCE_PATH")]
    public const string RESOURCE_PATH;

    [CCode (cheader_filename = "config.h", cname = "VERSION")]
    public const string VERSION;

    [CCode (cheader_filename = "config.h", cname = "GETTEXT_PACKAGE")]
    public const string GETTEXT_PACKAGE;

    [CCode (cheader_filename = "config.h", cname = "LOCALEDIR")]
    public const string LOCALEDIR;
}
