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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/MainHeaderBar.ui")]
public class Rpy.MainHeaderBar : Gtk.Widget
{
	[GtkChild] private unowned Gtk.Shortcut _search_shortcut;
	[GtkChild] private unowned Gtk.Label _title_label;
	[GtkChild] private unowned Gtk.Stack _title_stack;

	private Gtk.Widget? _capture_widget;
	private Gtk.EventControllerKey? _capture_widget_controller;


	public Gtk.Widget? key_capture_widget
	{
		get { return this._capture_widget; }
		set
		{
			if (value == this._capture_widget)
			{
				return;
			}

			if (this._capture_widget != null && this._capture_widget_controller != null)
			{
				((!) this._capture_widget).remove_controller ((!) this._capture_widget_controller);
			}

			this._capture_widget = value;

			if (this._capture_widget != null)
			{
				this._capture_widget_controller = new Gtk.EventControllerKey ()
				{
					propagation_phase = Gtk.PropagationPhase.CAPTURE
				};

				((!) this._capture_widget_controller).key_pressed.connect (this.capture_widget_key_handled);
				((!) this._capture_widget_controller).key_pressed.connect (() => this.capture_widget_key_handled ());

				((!) this._capture_widget).add_controller ((!) this._capture_widget_controller);
			}
		}
	}

	public bool narrow_mode { get; set; }

	[GtkChild]
	public unowned Gtk.SearchEntry search_entry { get; }

	public bool search_mode { get; set; }
	public string? title { get; set; }


	private bool capture_widget_key_handled ()
		requires (this._capture_widget_controller != null)
	{
		if (!this.get_mapped () || this.search_entry.has_focus)
		{
			return Gdk.EVENT_PROPAGATE;
		}

		bool handled = ((!) this._capture_widget_controller).forward (this);

		if (handled == Gdk.EVENT_STOP)
		{
			this.search_mode = true;
		}

		return handled;
	}

	[GtkCallback]
	private void deactivate_search_mode ()
	{
		this.search_mode = false;
	}

	[GtkCallback]
	private void update_header_bar_mode ()
	{
		if (this.narrow_mode && this.search_mode)
		{
			this._title_stack.visible_child = this.search_entry;
		}
		else if (this.narrow_mode && !this.search_mode)
		{
			this._title_stack.visible_child = this._title_label;
		}
		else
		{
			this._title_stack.visible_child = this.search_entry;
		}

		if (this.search_mode)
		{
			this.search_entry.grab_focus ();
			this.search_entry.set_position (int.MAX);
		}
		else
		{
			this.search_entry.text = "";
		}
	}


	construct
	{
		this.search_entry.set_key_capture_widget (this);

		this._search_shortcut.action = new Gtk.CallbackAction (() => this.search_mode = true);
	}
}
