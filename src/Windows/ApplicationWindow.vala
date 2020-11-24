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

[GtkTemplate (ui = "/io/github/nahuelwexd/Replay/ApplicationWindow.ui")]
public class Rpy.ApplicationWindow : Hdy.ApplicationWindow
{
	[GtkChild] private Rpy.BottomNavigationBar _bottom_navigation_bar;
	[GtkChild] private Rpy.HeaderBar           _header_bar;
	[GtkChild] private Rpy.NavigationSidebar   _navigation_sidebar;
	[GtkChild] private Gtk.Stack               _stack;

	private Rpy.AdaptiveMode _adaptive_mode;


	public Rpy.AdaptiveMode adaptive_mode
	{
		get { this._adaptive_mode; }
		set
		{
			if (this._adaptive_mode == value) return;
			this._adaptive_mode = value;

			switch (this._adaptive_mode)
			{
				case Rpy.AdaptiveMode.NARROW:
					this._bottom_navigation_bar.reveal = true;
					this._navigation_sidebar.reveal = false;
					break;
				case Rpy.AdaptiveMode.NORMAL:
					this._bottom_navigation_bar.reveal = false;
					this._navigation_sidebar.reveal = true;
					break;
			}
		}
	}

	public new Gtk.Application application
	{
		get { return base.application; }
		construct
		{
			if (base.application == value) return;
			base.application = value;
		}
	}


	public ApplicationWindow (Gtk.Application application)
	{
		GLib.Object (
			application: application
		);
	}


	public override void size_allocate (int width, int height, int baseline)
	{
		base.size_allocate (width, height, baseline);

		if (width < 576)
		{
			this.adaptive_mode = Rpy.AdaptiveMode.NARROW;
			this._header_bar.adaptive_mode = Rpy.AdaptiveMode.NARROW;
		}
		else
		{
			this.adaptive_mode = Rpy.AdaptiveMode.NORMAL;
			this._header_bar.adaptive_mode = Rpy.AdaptiveMode.NORMAL;
		}
	}


	construct
	{
		this.title = GLib.Environment.get_application_name () ?? "";
#if DEVEL
		this.add_css_class ("devel");
#endif
	}
}
