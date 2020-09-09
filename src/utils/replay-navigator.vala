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

namespace Replay.Navigator
{
	/* Private fields */

	private Gee.Deque<string>		 _history;
	private Gee.List<Replay.Section> _sections;

	/* End private fields */


	/* Public methods */

	public void register_section (Replay.Section section)
		ensures (Replay.Navigator._sections != null)
		ensures (Replay.Navigator._sections.size > 0)
	{
		if (Replay.Navigator._sections == null)
			Replay.Navigator._sections = new Gee.ArrayList<Section> ();

		Replay.Navigator._sections.add (section);
	}

	public bool push (string path)
		ensures (Replay.Navigator._history != null)
		ensures (Replay.Navigator._history.size > 1)
	{
		if (Replay.Navigator._history == null) {
			Replay.Navigator._history = new Gee.ArrayQueue<string> ();
			Replay.Navigator._history.offer_head ("/");
    	}

		if (Replay.Navigator.navigate (path)) {
			Replay.Navigator._history.offer_head (path);

			return true;
		}

		return false;
	}

	public bool pop ()
		requires (Replay.Navigator._history != null)
		requires (Replay.Navigator._history.size > 1)
	{
		string last_entry = Replay.Navigator._history.poll_head ();

		if (!Replay.Navigator.navigate (Replay.Navigator._history.peek_head ())) {
			Replay.Navigator._history.offer_head (last_entry);

			return false;
		}

		return true;
	}

	/* End public methods */


	/* Private methods */

	private bool navigate (string path)
	{
		var result = false;

		Replay.Navigator._sections.@foreach (section => {
			result = section.navigate (path) || result;

			return true;
		});

		return result;
	}

	/* End private methods */
}
