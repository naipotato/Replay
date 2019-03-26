/* Copyright (C) 2019 Nucleux Software
 *
 * This file is part of unitube-gtk.
 *
 * unitube-gtk is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * unitube-gtk is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY of FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with unitube-gtk.  If not, see <https://www.gnu.org/licenses/>.
 *
 * Author: Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 */

class UniTube.Core.Video : Resource, Object {

	public string kind { get; set; }

	public string etag { get; set; }

	public string id { get; set; }

	public VideoSnippet snippet { get; set; }
}

class UniTube.Core.VideoSnippet : Object {

	construct {
		this.thumbnails = new Gee.HashMap<string, Thumbnail> ();
		this.tags = new Gee.ArrayList<string> ();
	}

	public DateTime publishedAt { get; set; }

	public string channelId { get; set; }

	public string title { get; set; }

	public string description { get; set; }

	public Gee.HashMap<string, Thumbnail> thumbnails { get; private set; }

	public string channelTitle { get; set; }

	public Gee.ArrayList<string> tags { get; private set; }

	public string categoryId { get; set; }

	public string liveBroadcastContent { get; set; }

	public string defaultLanguage { get; set; }

	public VideoLocalization localized { get; set; }

	public string defaultAudioLanguage { get; set; }
}

class UniTube.Core.VideoLocalization : Object {

	public string title { get; set; }

	public string description { get; set; }
}
