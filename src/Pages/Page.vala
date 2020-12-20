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

public abstract class Rpy.Page : Gtk.Widget, Gtk.Buildable
{
	private Gtk.Widget? _child;
	private bool _child_vexpand_previous_value;
	private Gtk.Widget? _titlebar;


	public Gtk.Widget? child
	{
		get { return this._child; }
		set
		{
			if (value == this._child)
				return;

			if (this._child != null)
			{
				((!) this._child).vexpand = this._child_vexpand_previous_value;
				((!) this._child).unparent ();
			}

			this._child = value;

			if (this._child != null)
			{
				((!) this._child).vexpand = true;
				((!) this._child).set_parent (this);
			}
		}
	}

	public Rpy.NavigationService? navigation_service { get; construct; }

	public Gtk.Widget? titlebar
	{
		get { return this._titlebar; }
		set
		{
			if (value == this._titlebar)
				return;

			if (this._titlebar != null)
				((!) this._titlebar).unparent ();

			this._titlebar = value;

			if (this._titlebar != null)
				((!) this._titlebar).set_parent (this);
		}
	}


	public void add_child (Gtk.Builder builder, GLib.Object child, string? type)
	{
		if (child is Gtk.Widget && type == "titlebar")
			this.titlebar = (Gtk.Widget) child;
		else if (child is Gtk.Widget)
			this.child = (Gtk.Widget) child;
		else
			base.add_child (builder, child, type);
	}

	public override void dispose ()
	{
		this.child = null;
		this.titlebar = null;
		base.dispose ();
	}

	public virtual void on_navigated_to (GLib.Value? parameter = null) { }


	construct
	{
		this.layout_manager = new Gtk.BoxLayout (Gtk.Orientation.VERTICAL);
	}
}
