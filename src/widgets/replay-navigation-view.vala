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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/navigation-view-item.ui")]
public class Replay.NavigationViewItem : Gtk.Widget
{
    /* Private fields */

    [GtkChild] private Gtk.Image _image;
    [GtkChild] private Gtk.Label _gtk_label;

    /* End private fields */


    /* Public properties */

    public string tag       { get; set; }
    public string icon_name { get; set; }
    public string label     { get; set; }

    /* End public properties */


    /* Public methods */

    public override void dispose ()
    {
        this._image.unparent ();
        this._gtk_label.unparent ();
        base.dispose ();
    }

    /* End public methods */
}

public class Replay.NavigationView : Gtk.Widget, Gtk.Buildable
{
    /* Private fields */

    private Gtk.ListBox   _navigation_sidebar;
    private Gtk.Separator _separator;
    private Gtk.Widget    _child;

    /* End private fields */


    /* Public properties */

    public Gtk.Widget child
    {
        get { return this._child; }
        set
        {
            if (this._child != null)
                this._child.unparent ();

            this._child = value;

            if (this._child != null)
                this._child.set_parent (this);
        }
    }

    /* End public properties */


    /* Public signals */

    public signal void item_selected (Replay.NavigationViewItem? item);

    /* End public signals */


    /* Public methods */

    public void add_child (Gtk.Builder builder, Object child, string? type)
        requires (child is Replay.NavigationViewItem && type == "item" || child is Gtk.Widget)
    {
        if (child is Replay.NavigationViewItem && type == "item")
            this._navigation_sidebar.append ((Replay.NavigationViewItem) child);
        else if (child is Gtk.Widget)
            this.child = (Gtk.Widget) child;
    }

    public override void dispose ()
    {
        this._navigation_sidebar.unparent ();
        this._separator.unparent ();
        this.child = null;
        base.dispose ();
    }

    /* End public methods */


    /* GObject blocks */

    construct
    {
        this._navigation_sidebar = new Gtk.ListBox () {
            width_request = 180,
            css_classes   = { "navigation-sidebar" }
        };

        this._navigation_sidebar.row_selected.connect (
            row => this.item_selected (row != null ? row.child as Replay.NavigationViewItem : null)
        );

        this._navigation_sidebar.set_parent (this);

        this._separator = new Gtk.Separator (Gtk.Orientation.VERTICAL);
        this._separator.set_parent (this);
    }

    static construct
    {
        set_layout_manager_type (typeof (Gtk.BoxLayout));
    }

    /* End GObject blocks */
}
