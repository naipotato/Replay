/* Replay - Explore and watch YouTube videos
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

public class Rpy.NavigationService : GLib.Object
{
	private Gee.Map? _page_keys;


	public signal void navigation_requested (Rpy.Page page);

	[Signal (action = true)]
	public signal void go_back ();


	public Gee.Map<TKey, GLib.Type> get_page_keys<TKey> ()
		requires (typeof (TKey).is_enum ())
	{
		if (this._page_keys != null && ((!) this._page_keys).key_type.is_a (typeof (TKey)))
			return (!) this._page_keys;

		return (!) (this._page_keys = new Gee.HashMap<TKey, GLib.Type> ());
	}

	public void navigate<TKey> (TKey page_key, GLib.Value? parameter = null)
	{
		Gee.Map<TKey, GLib.Type> page_keys = this.get_page_keys ();
		GLib.return_if_fail (page_keys.has_key (page_key));

		GLib.Type page_type = page_keys[page_key];
		GLib.return_if_fail (page_type.is_a (typeof (Rpy.Page)));

		var page = (Rpy.Page) GLib.Object.@new (page_type, "navigation-service", this);

		this.navigation_requested (page);
		page.on_navigated_to (parameter);
	}
}
