/* Replay - A new way to watch YouTube videos
 * Copyright 2019 - 2020 Nahuel Gomez Castro <nahuel.gomezcastro@outlook.com.ar>
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

[GtkTemplate (ui = "/ui/github/nahuelwexd/Replay/BottomNavigationBar.ui")]
public class Rpy.BottomNavigationBar : Gtk.Widget
{
	[GtkChild] private Gtk.Revealer _revealer;


	public override void dispose ()
	{
		this._revealer.unparent ();
		base.dispose ();
	}
}
