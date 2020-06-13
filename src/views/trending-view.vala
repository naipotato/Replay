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

using Gtk;
using Utlib;

namespace Replay {

    [GtkTemplate (ui = "/com/github/nahuelwexd/Replay/gtk/trending-view.ui")]
    public class TrendingView : Bin {

        private TrendingViewModel view_model;
        [GtkChild] private Stack stack;
        [GtkChild] private FlowBox videos_box;

        construct {
            this.view_model = ViewModelLocator.get_default ().trending;
            this.view_model.notify["state"].connect (on_view_model_state_changed);
            this.view_model.notify_property ("state");

            this.videos_box.bind_model (this.view_model.trending_videos, build_video_tile);
        }

        private void on_view_model_state_changed () {
            switch (this.view_model.state) {
                case TrendingViewModel.State.LOADING:
                    this.stack.visible_child_name = "loading";
                    break;
                case TrendingViewModel.State.ERROR:
                    this.stack.visible_child_name = "error";
                    break;
                case TrendingViewModel.State.SUCCESS:
                    this.stack.visible_child_name = "videos";
                    break;
            }
        }

        private Widget build_video_tile (Object item) {
            var video = item as Video;
            return new VideoTile () {
                thumbnail_url = video.snippet.thumbnails["high"].url,
                title = video.snippet.title,
                channel_title = video.snippet.channel_title
            };
        }
    }
}
