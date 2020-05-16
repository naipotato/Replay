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

using Utlib;
using Unitube.Utils;

namespace Unitube {

    public class TrendingViewModel : Object {

        public GenericListModel<Video> trending_videos { get; set; }

        construct {
            // Let's get for some trending videos ;)
            load_trending_videos.begin ();
        }

        private async void load_trending_videos () {
            // Create a new request
            var request = App.client.videos.list ("snippet");

            // Request for trending videos on US
            // TODO: region_code should be attached to the user region
            request.chart = "mostPopular";
            request.region_code = "US";

            try {
                // Try to execute the request
                var response = request.execute ();

                // Once the response is received, fill the list with the videos
                // received
                this.trending_videos = new GenericListModel<Video>.from_list (
                    response.items);
            } catch (Error e) {
                // Warn for the dev ;)
                warning (e.message);
            }
        }
    }
}
