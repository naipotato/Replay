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

abstract class UniTube.Core.Request<T> : Object {

	private Gee.HashMap<string, string> parameters;

	public Request () {
		this.parameters = new Gee.HashMap<string, string> ();
	}

	public string? access_token {
		owned get {
			return this.get_property_string ("access_token");
		}
		set {
			this.set_property_string ("access_token", value);
		}
	}

	public string? callback {
		owned get {
			return this.get_property_string ("callback");
		}
		set {
			this.set_property_string ("callback", value);
		}
	}

	public string? fields {
		owned get {
			return this.get_property_string ("fields");
		}
		set {
			this.set_property_string ("fields", value);
		}
	}

	public string? key {
		owned get {
			return this.get_property_string ("key");
		}
		set {
			this.set_property_string ("key", value);
		}
	}

	public string? pretty_print {
		owned get {
			return this.get_property_string ("prettyPrint");
		}
		set {
			this.set_property_string ("prettyPrint", value);
		}
	}

	public string? quota_user {
		owned get {
			return this.get_property_string ("quotaUser");
		}
		set {
			this.set_property_string ("quotaUser", value);
		}
	}

	public string? user_ip {
		owned get {
			return this.get_property_string ("userIp");
		}
		set {
			this.set_property_string ("userIp", value);
		}
	}

	protected string? get_property_string (string property) {
		if (this.parameters.has_key (property)) {
			return this.parameters[property];
		} else {
			return null;
		}
	}

	protected void set_property_string (string property, string? value) {
		if (value != null && value != "") {
			this.parameters[property] = value;
		} else {
			this.parameters.unset (property);
		}
	}

	protected long get_property_long (string property) {
		if (this.parameters.has_key (property)) {
			return long.parse (this.parameters[property]);
		} else {
			return -1;
		}
	}

	protected void set_property_long (string property, long value) {
		if (value > -1) {
			this.parameters[property] = value.to_string ();
		} else {
			this.parameters.unset (property);
		}
	}

	protected string get_parameters () {
		var joined_pairs = new Gee.ArrayList<string> ();

		foreach (var item in this.parameters.entries) {
			if (item.value != null && item.value != "") {
				joined_pairs.add (Soup.URI.encode (item.key, null) + "=" +
					Soup.URI.encode (item.value, null));
			}
		}

		return string.joinv ("&", joined_pairs.to_array ());
	}

	public abstract T execute () throws ApiError;

	public async abstract T execute_async () throws ApiError;
}
