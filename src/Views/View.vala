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

public class Rpy.View : Gtk.Widget, Gtk.Buildable
{
	private Gtk.Widget? _child;


	public Gtk.Widget? child
	{
		get { return this._child; }
		set
		{
			if (this._child == value)
				return;

			if (this._child != null)
				((!) this._child).unparent ();

			this._child = value;

			if (this._child != null)
				((!) this._child).set_parent (this);
		}
	}

	public string? icon_name { get; set; }
	public new string? name { get; set; }
	public string? title { get; set; }
	public bool visible_on_narrow { get; set; default = true; }
	public bool visible_on_normal { get; set; default = true; }


	public void add_child (Gtk.Builder builder, GLib.Object child, string? type)
	{
		if (child is Gtk.Widget)
			this.child = (Gtk.Widget) child;
		else
			base.add_child (builder, child, type);
	}


	static construct
	{
		set_layout_manager_type (typeof (Gtk.BinLayout));
	}
}
