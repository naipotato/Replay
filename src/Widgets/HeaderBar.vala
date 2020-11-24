/* Replay - An open source YouTube client for GNOME
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

[GtkTemplate (ui = "/io/github/nahuelwexd/Replay/HeaderBar.ui")]
public class Rpy.HeaderBar : Gtk.Widget
{
	[GtkChild] private Hdy.Clamp       _clamp;
	[GtkChild] private Hdy.HeaderBar   _header_bar;
	[GtkChild] private Gtk.Label       _label;
	[GtkChild] private Gtk.SearchEntry _search_entry;
	[GtkChild] private Gtk.Stack       _stack;

	private Rpy.AdaptiveMode _adaptive_mode;


	public Rpy.AdaptiveMode adaptive_mode
	{
		get { return this._adaptive_mode; }
		set
		{
			if (this._adaptive_mode == value) return;
			this._adaptive_mode = value;

			switch (this._adaptive_mode)
			{
				case Rpy.AdaptiveMode.NARROW:
					this._stack.visible_child = this._label;
					break;
				case Rpy.AdaptiveMode.NORMAL:
					this._stack.visible_child = this._clamp;
					break;
			}
		}
	}

	public string title { get; set; }


	public override void dispose ()
	{
		this._header_bar.unparent ();
		base.dispose ();
	}
}
