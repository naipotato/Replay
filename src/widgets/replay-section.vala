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

public class Replay.Section : Gtk.Widget, Gtk.Buildable
{
	/* Private fields */

	private Gee.List<Replay.Page> _pages;
	private Gtk.Stack			  _stack;

	/* Private fields */


	/* Public methods */

	public void add_child (Gtk.Builder builder, Object child, string? type)
		requires (child is Replay.Page)
	{
		this.add_page ((Replay.Page) child);
	}

	public void add_page (Replay.Page page)
	{
		this._pages.add (page);
		this._stack.add_named (page, null);
	}

	public override void dispose ()
	{
		this._stack.unparent ();
		base.dispose ();
	}

	public bool navigate (string path)
	{
		Replay.Page? page = this._pages.first_match (
			page => page.exact ? path == page.path : path.has_prefix (page.path)
		);

		if (page != null) {
			this._stack.visible_child = page;

			return true;
		}

		return false;
	}

	/* End public methods */


	/* GObject blocks */

	construct
	{
		this._pages = new Gee.ArrayList<Replay.Page> ();

		this._stack = new Gtk.Stack ();
		this._stack.set_parent (this);

		Replay.Navigator.register_section (this);
	}

	static construct
	{
		set_layout_manager_type (typeof (Gtk.BinLayout));
	}

	/* End GObject blocks */
}
