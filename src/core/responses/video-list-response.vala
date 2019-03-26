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

class UniTube.Core.VideoListResponse : Object {

	construct {
		this.items = new Gee.ArrayList<Video> ();
	}

	public string kind { get; set; }

	public string etag { get; set; }

	public string nextPageToken { get; set; }

	public string prevPageToken { get; set; }

	public PageInfo pageInfo { get; set; }

	public Gee.ArrayList<Video> items { get; private set; }
}

class UniTube.Core.PageInfo : Object {

	public int totalResults { get; set; }

	public int resultsPerPage { get; set; }
}
