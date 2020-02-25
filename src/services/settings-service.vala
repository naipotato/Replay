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

    public class SettingsService : Object {

        private static GLib.Once<SettingsService> instance;

        public AppearanceSettings appearance { get; private set; }

        private SettingsService () {
            appearance = new AppearanceSettings (@"$(Config.APP_ID).appearance");
        }

        public static unowned SettingsService get_default () {
            return instance.once (() => {
                return new SettingsService ();
            });
        }
    }
}
