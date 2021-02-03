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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/LibraryView.ui")]
public class Rpy.LibraryView : Rpy.View
{
	[GtkChild] private unowned Rpy.ViewList _view_list;

	private Rpy.ObservableList<Rpy.View>? _views;


	[GtkChild]
	public unowned Hdy.Leaflet leaflet { get; }

	[GtkChild]
	public unowned Gtk.Stack stack { get; }

	public Rpy.ObservableList<Rpy.View>? views
	{
		get { return this._views; }
		construct
		{
			if (value == null)
			{
				return;
			}

			this._views = value;

			this._view_list.model = this._views;
			foreach (Rpy.View view in (!) this._views)
			{
				this._stack.add_child (view);
			}
		}
	}


	public LibraryView (Rpy.ObservableList<Rpy.View> views)
	{
		GLib.Object (
			views: views
		);
	}


	[GtkCallback]
	private void on_view_list_selected_view_changed ()
	{
		if (this._view_list.selected_view == null)
		{
			return;
		}

		this.leaflet.visible_child = this.stack;
		this.stack.visible_child = (!) this._view_list.selected_view;
		this._view_list.selected_view = null;
	}
}
