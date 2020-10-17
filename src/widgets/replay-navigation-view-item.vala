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
