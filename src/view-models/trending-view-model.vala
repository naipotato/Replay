/* Replay - An open source YouTube client for GNOME
 * Copyright (C) 2019 - 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
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

using Utlib;
using Replay.Utils;

namespace Replay {

    /**
     * The model view of the trending view
     */
    public class TrendingViewModel : Object {

        /**
         * A value indicating whether or not to display the loading screen
         */
        public bool is_loading_videos { get; set; }

        /**
         * The trending video list
         */
        public GenericListModel<Video> trending_videos { get; set; }

        /**
         * A value indicating whether or not to display the error screen
         */
        public bool error_loading_videos { get; set; }

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
                // This should show a nicer loading screen to the user
                this.is_loading_videos = true;

                // Try to execute the request
                var response = yield request.execute_async ();

                // Once the response is received, fill the list with the videos
                // received
                this.trending_videos = new GenericListModel<Video>.from_list (
                    response.items);

                // Hide the loading screen and show videos
                this.is_loading_videos = false;
            } catch (Error e) {
                // If there was any error, show an error message to the user
                this.error_loading_videos = true;

                // Warn for the dev ;)
                warning (e.message);
            }
        }
    }
}
