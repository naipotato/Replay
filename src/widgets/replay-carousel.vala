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

public class Replay.Carousel : Gtk.Widget, Gtk.Buildable
{
	/* Private fields */

	private Gtk.Overlay			 _overlay;
	private Gtk.Stack			 _stack;
	private Gee.List<Gtk.Widget> _items;
	private uint				 _interval;
	private uint				 _source_id;

	/* End private fields */


	/* Public properties */

	public uint transition_duration { get; set; default = 500; }

	public uint interval
	{
		get { return this._interval; }
		set
		{
			if (this._interval != 0 && this._source_id != 0)
				Source.remove (this._source_id);

			this._interval = value;

			if (this._interval != 0) {
				this._source_id = Timeout.add (this._interval, () => {
					this.on_next_button_clicked ();

					return Source.CONTINUE;
				});
			}
		}
	}

	/* End public properties */


	/* Public methods */

	public void add_child (Gtk.Builder builder, Object child, string? type)
		requires (child is Gtk.Widget)
	{
		this.add_item ((Gtk.Widget) child);
	}

	public void add_item (Gtk.Widget item)
	{
		this._stack.add_named (item, null);
		this._items.add (item);
	}

	public override void dispose ()
	{
		this._overlay.unparent ();
		base.dispose ();
	}

	/* End public methods */


	/* Private methods */

	private void on_previous_button_clicked ()
		requires (this._items.contains (this._stack.visible_child))
	{
		int current_index = this._items.index_of (this._stack.visible_child);

		if (current_index != 0)
			this._stack.visible_child = this._items[current_index - 1];
		else
			this._stack.visible_child = this._items.last ();
  	}

	private void on_next_button_clicked ()
		requires (this._items.contains (this._stack.visible_child))
	{
		int current_index = this._items.index_of (this._stack.visible_child);

		if (current_index < (this._items.size - 1))
			this._stack.visible_child = this._items[current_index + 1];
		else
			this._stack.visible_child = this._items.first ();
	}

	/* End private methods */


	/* GObject blocks */

	construct
	{
		this._overlay = new Gtk.Overlay ();
		this._overlay.set_parent (this);

		this._stack = new Gtk.Stack () { transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT };
		this.bind_property ("transition-duration",
			this._stack, "transition-duration",
			BindingFlags.SYNC_CREATE | BindingFlags.DEFAULT
		);
		this._overlay.child = this._stack;

		var previous_button = new Gtk.Button () {
			halign		  = Gtk.Align.START,
			width_request = 150,
			css_classes	  = { "left" },
			child		  = new Gtk.Image.from_icon_name ("go-previous-symbolic") { halign = Gtk.Align.START }
		};
		previous_button.clicked.connect (this.on_previous_button_clicked);
		this._overlay.add_overlay (previous_button);

		var next_button = new Gtk.Button () {
			halign		  = Gtk.Align.END,
			width_request = 150,
			css_classes	  = { "right" },
			child		  = new Gtk.Image.from_icon_name ("go-next-symbolic") { halign = Gtk.Align.END }
		};
		next_button.clicked.connect (this.on_next_button_clicked);
		this._overlay.add_overlay (next_button);

		this._items = new Gee.ArrayList<Gtk.Widget> ();
		this.interval = 5000;
	}

	static construct
	{
		set_layout_manager_type (typeof (Gtk.BinLayout));
		set_css_name ("carousel");
	}

	/* End GObject blocks */
}
