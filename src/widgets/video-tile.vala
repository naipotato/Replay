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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/video-tile.ui")]
class VideoTile : Gtk.Box {

    private static ThreadPool<VideoTile> _pool;

    [GtkChild] private Gtk.Image _thumbnail;

    public string thumbnail_url { get; set; }
    public string title { get; set; }
    public string channel_title { get; set; }

    static construct {
        try {
            VideoTile._pool = new ThreadPool<VideoTile>.with_owned_data ((video_tile) => {
                video_tile.load_thumbnail ();
            }, 3, false);
        } catch (ThreadError e) {
            warning (@"ThreadError: $(e.message)");
        }
    }

    construct {
        this.notify["thumbnail-url"].connect (() => {
            try {
                VideoTile._pool.add (this);
            } catch (ThreadError e) {
                warning (@"ThreadError: $(e.message)");
            }
        });
    }

    private void load_thumbnail () {
        var session = new Soup.Session ();
        var message = new Soup.Message ("GET", this.thumbnail_url);

        try {
            var istream = session.send (message);
            this._thumbnail.pixbuf = new Gdk.Pixbuf.from_stream (istream);
        } catch (Error e) {
            this._thumbnail.icon_name = "image-missing";
            warning (e.message);
        }
    }
}
