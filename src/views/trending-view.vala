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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/gtk/trending-view.ui")]
class Replay.TrendingView : Gtk.Bin {

    private Replay.TrendingViewModel _view_model;
    [GtkChild] private Gtk.Stack _stack;
    [GtkChild] private Gtk.FlowBox _videos_box;

    construct {
        this._view_model = Replay.ViewModelLocator.get_default ().trending;
        this._view_model.notify["state"].connect (this.on_view_model_state_changed);
        this._view_model.notify_property ("state");

        this._videos_box.bind_model (this._view_model.trending_videos, this.build_video_tile);
    }

    private void on_view_model_state_changed () {
        switch (this._view_model.state) {
            case Replay.ViewModelState.LOADING:
                this._stack.visible_child_name = "loading";
                break;
            case Replay.ViewModelState.ERROR:
                this._stack.visible_child_name = "error";
                break;
            case Replay.ViewModelState.SUCCESS:
                this._stack.visible_child_name = "videos";
                break;
            default:
                assert_not_reached ();
        }
    }

    private Gtk.Widget build_video_tile (Object item) {
        var video = item as Utlib.Video;
        return new Replay.VideoTile () {
            thumbnail_url = video.snippet.thumbnails["high"].url,
            title = video.snippet.title,
            channel_title = video.snippet.channel_title
        };
    }
}
