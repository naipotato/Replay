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

enum ViewModelState {
    LOADING, ERROR, SUCCESS;
}

[SingleInstance]
class TrendingViewModel : Object {

    public ViewModelState state { get; set; }
    public Utils.GenericListModel<Utlib.Video> trending_videos { get; set; }

    construct {
        this.trending_videos = new Utils.GenericListModel<Utlib.Video> ();
        this.load_trending_videos.begin ();
    }

    private async void load_trending_videos () {
        // Create a new request
        var request = App.client.videos.list ("snippet");

        // Request for trending videos on US
        // TODO: region_code should be attached to the user region
        request.chart = Utlib.ChartEnum.MOST_POPULAR;
        request.region_code = "US";
        request.max_results = 50;

        try {
            // This should show a nicer loading screen to the user
            this.state = ViewModelState.LOADING;

            // Try to execute the request
            var response = yield request.execute_async ();

            // Once the response is received, fill the list with the videos received
            this.trending_videos.add_all (response.items);

            // Hide the loading screen and show videos
            this.state = ViewModelState.SUCCESS;
        } catch (Error e) {
            // If there was any error, show an error message to the user
            this.state = ViewModelState.ERROR;

            // Warn to the dev ;)
            warning (e.message);
        }
    }
}
