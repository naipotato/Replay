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

namespace Unitube {

    public class ViewModelLocator {

        private static Once<ViewModelLocator> instance;

        public TrendingViewModel trending { get; set; }

        private ViewModelLocator () {
            this.trending = new TrendingViewModel ();
        }

        public static unowned ViewModelLocator get_default () {
            return instance.once (() => {
                return new ViewModelLocator ();
            });
        }
    }
}
