/* Replay - An open source YouTube client for GNOME
 * Copyright 2019 - 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * Replay is free software: you can redistribute it and/or modify it under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * Replay is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Replay.  If not, see <https://www.gnu.org/licenses/>.
 */

public class Replay.Core.Video : Object
{
	/* Public properties */

	public string					kind	{ get; set; }
	public string					etag	{ get; set; }
	public string					id		{ get; set; }
	public Replay.Core.VideoSnippet snippet { get; set; }

	/* End public properties */
}

public class Replay.Core.VideoSnippet : Object
{
	/* Public properties */

	public DateTime											  published_at			 { get; set; }
	public string											  channel_id			 { get; set; }
	public string											  title					 { get; set; }
	public string											  description			 { get; set; }
	public Gee.Map<string, Replay.Core.Thumbnail>			  thumbnails			 { get; }
	public string											  channel_title			 { get; set; }
	public Gee.List<string>									  tags					 { get; }
	public string											  category_id			 { get; set; }
	public Replay.Core.LiveBroadcastContentEnum				  live_broadcast_content { get; set; }
	public string											  default_language		 { get; set; }
	public Gee.Map<string, Replay.Core.VideoLocalization>	  localized				 { get; }
	public string 											  default_audio_language { get; set; }

	/* End public properties */


	/* GObject blocks */

	construct
	{
		this._thumbnails = new Gee.HashMap<string, Replay.Core.Thumbnail> ();
		this._tags		 = new Gee.ArrayList<string> ();
		this._localized	 = new Gee.HashMap<string, Replay.Core.VideoLocalization> ();
	}

	/* GObject blocks */
}

public enum Replay.Core.LiveBroadcastContentEnum
{
	LIVE,
	NONE,
	UPCOMING;
}

public class Replay.Core.VideoLocalization : Object
{
	/* Public properties */

	public string title		  { get; set; }
	public string description { get; set; }

	/* End public properties */
}
