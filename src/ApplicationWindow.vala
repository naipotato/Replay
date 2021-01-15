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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/ApplicationWindow.ui")]
public class Rpy.ApplicationWindow : Hdy.ApplicationWindow
{
	[GtkChild] private Hdy.Leaflet _leaflet;

	private Rpy.NavigationService? _navigation_service;


	public Rpy.NavigationService? navigation_service
	{
		construct
		{
			if (this._navigation_service == value)
				return;

			this._navigation_service = value;

			((!) this._navigation_service).navigation_requested.connect (this.on_navigation_requested);
			((!) this._navigation_service).go_back.connect (this.on_back_requested);
		}
	}


	public ApplicationWindow (Rpy.Application app, Rpy.NavigationService nav_service)
	{
		GLib.Object (
			application: app,
			navigation_service: nav_service
		);
	}


	private void on_back_requested ()
	{
		this._leaflet.navigate (Hdy.NavigationDirection.BACK);
	}

	[GtkCallback]
	private void on_leaflet_child_transition_running_changed ()
	{
		this.try_remove_page ();
	}

	[GtkCallback]
	private void on_leaflet_visible_child_changed ()
	{
		this.try_remove_page ();
	}

	private void on_navigation_requested (Rpy.Page page)
	{
		if (page.get_parent () != this._leaflet)
			this._leaflet.append (page);

		this._leaflet.visible_child = page;
	}

	// TODO: We need to do this in a less hacky way
	private void try_remove_page ()
	{
		if (this._leaflet.child_transition_running)
			return;

		Gtk.Widget? child = this._leaflet.get_first_child ();
		while (child != null)
		{
			Gtk.Widget page = (!) child;
			child = page.get_next_sibling ();

			if (page == this._leaflet.visible_child)
				break;

			this._leaflet.remove ((!) page);
		}
	}


	construct
	{
#if DEVEL
		this.add_css_class ("devel");
#endif
	}
}
