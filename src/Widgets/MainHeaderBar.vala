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
	[GtkChild] private unowned Gtk.SearchEntry _search_entry;
	[GtkChild] private unowned Gtk.Shortcut _shortcut;
	[GtkChild] private unowned Gtk.Label _title_label;
	[GtkChild] private unowned Gtk.Stack _title_stack;

	private weak Gtk.Widget? _capture_widget;
	private Gtk.EventControllerKey _capture_widget_controller;
	private bool _narrow_mode = true;
	private bool _search_mode;


	// Some bits stolen from https://gitlab.gnome.org/GNOME/gtk/-/blob/master/gtk/gtksearchbar.c and
	// ported to Vala.
	public Gtk.Widget? key_capture_widget
	{
		get { return this._capture_widget; }
		set
		{
			if (this._capture_widget == value)
				return;

			if (this._capture_widget != null)
				((!) this._capture_widget).remove_controller (this._capture_widget_controller);

			this._capture_widget = value;

			if (this._capture_widget != null)
			{
				this._capture_widget_controller = new Gtk.EventControllerKey ()
				{
					propagation_phase = Gtk.PropagationPhase.CAPTURE
				};

				this._capture_widget_controller.key_pressed.connect (this.capture_widget_key_handled);
				this._capture_widget_controller.key_released.connect (
					(keyval, keycode, state) => this.capture_widget_key_handled (keyval, keycode, state));

				((!) this._capture_widget).add_controller (this._capture_widget_controller);
			}
		}
	}

	public bool narrow_mode
	{
		get { return this._narrow_mode; }
		set
		{
			if (this._narrow_mode == value)
				return;

			this._narrow_mode = value;

			if (this._narrow_mode && this.search_mode)
				this._title_stack.visible_child = this._search_entry;
			else if (this._narrow_mode && !this.search_mode)
				this._title_stack.visible_child = this._title_label;
			else
				this._title_stack.visible_child = this._search_entry;
		}
	}

	public Gtk.SearchEntry search_entry
	{
		get { return this._search_entry; }
	}

	public bool search_mode
	{
		get { return this._search_mode; }
		set
		{
			if (this._search_mode == value)
				return;

			this._search_mode = value;

			if (this._search_mode)
			{
				if (this.narrow_mode)
					this._title_stack.visible_child = this._search_entry;

				this._search_entry.grab_focus ();
				this._search_entry.set_position (int.MAX);
			}
			else
			{
				if (this.narrow_mode)
					this._title_stack.visible_child = this._title_label;

				this._search_entry.text = "";
			}
		}
	}

	public string? title { get; set; }


	// More bits stolen from https://gitlab.gnome.org/GNOME/gtk/-/blob/master/gtk/gtksearchbar.c,
	// ported to Vala, and modified for Replay.
	private bool capture_widget_key_handled (uint keyval, uint keycode, Gdk.ModifierType state)
	{
		if (!this.get_mapped ())
			return Gdk.EVENT_PROPAGATE;

		if (this._search_entry.has_focus)
			return Gdk.EVENT_PROPAGATE;

		bool handled = this._capture_widget_controller.forward (this);

		if (handled == Gdk.EVENT_STOP)
			this.search_mode = true;

		return handled;
	}

	[GtkCallback]
	private void on_search_entry_stop_search ()
	{
		this.search_mode = false;
	}


	construct
	{
		this._search_entry.set_key_capture_widget (this);

		this._shortcut.action = new Gtk.CallbackAction (() => {
			this.search_mode = true;
		});
	}
}
