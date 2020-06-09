/* UTLib - Yet another wrapper to the YouTube Data API v3.
 * Copyright (C) 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * This library is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

public class Utlib.VideoSnippet : Object {

    [Description (nick = "json::publishedAt")]
    public DateTime published_at { get; set; }
    [Description (nick = "json::channelId")]
    public string channel_id { get; set; }
    public string title { get; set; }
    public string description { get; set; }
    public Gee.Map<string, Utlib.Thumbnail> thumbnails { get; private set; }
    [Description (nick = "json::channelTitle")]
    public string channel_title { get; set; }
    public Gee.List<string> tags { get; private set; }
    [Description (nick = "json::categoryId")]
    public string category_id { get; set; }
    [Description (nick = "json::liveBroadcastContent")]
    public string live_broadcast_content { get; set; }
    [Description (nick = "json::defaultLanguage")]
    public string default_language { get; set; }
    public Utlib.VideoLocalization localized { get; set; }
    [Description (nick = "json::defaultAudioLanguage")]
    public string default_audio_language { get; set; }

    construct {
        this.thumbnails = new Gee.HashMap<string, Utlib.Thumbnail> ();
        this.tags = new Gee.ArrayList<string> ();
    }
}
