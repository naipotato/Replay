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

        public enum State {
            LOADING,
            ERROR,
            SUCCESS
        }

        public State state { get; set; }
        public GenericListModel<Video> trending_videos { get; set; default = new GenericListModel<Video> (); }

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
                this.state = State.LOADING;

                // Try to execute the request
                var response = yield request.execute_async ();

                // Once the response is received, fill the list with the videos
                // received
                this.trending_videos = new GenericListModel<Video>.from_list (
                    response.items);

                // Hide the loading screen and show videos
                this.state = State.SUCCESS;
            } catch (Error e) {
                // If there was any error, show an error message to the user
                this.state = State.ERROR;

                // Warn for the dev ;)
                warning (e.message);
            }
        }
    }
}
