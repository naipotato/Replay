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
using Soup;

namespace Replay {

    [GtkTemplate (ui = "/com/github/nahuelwexd/Replay/gtk/video-tile.ui")]
    public class VideoTile : Gtk.Box {

        [GtkChild] private Image thumbnail;

        public string thumbnail_url { get; set; }
        public string title { get; set; }
        public string channel_title { get; set; }

        construct {
            this.notify["thumbnail-url"].connect (() => {
                load_thumbnail.begin ();
            });
        }

        private async void load_thumbnail () {
            if (thumbnail_url == null) {
                message (@"$(this.title)");
                return;
            }

            var session = new Session ();
            var message = new Message ("GET", thumbnail_url);

            var istream = yield session.send_async (message);
            this.thumbnail.pixbuf = yield new Gdk.Pixbuf.from_stream_at_scale_async (istream, 360, 1000, true);
        }
    }
}
