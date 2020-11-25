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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/VideoCarouselItem.ui")]
public class Replay.VideoCarouselItem : Gtk.Widget
{
    /* Private fields */

    [GtkChild] private Gtk.Picture _thumbnail;

    /* End private fields */


    /* Public properties */

    public string thumbnail_url { get; set; }
    public string title         { get; set; }
    public string channel_title { get; set; }

    /* End public properties */


    /* Public methods */

    public override void snapshot (Gtk.Snapshot snapshot)
    {
        var rect = Graphene.Rect ().init (0, 0, this.get_width (), this.get_height ());
        var rounded_rect = Gsk.RoundedRect ().init_from_rect (rect, 6.0f);

        snapshot.push_rounded_clip (rounded_rect);

        base.snapshot (snapshot);

        snapshot.pop ();
    }

    /* End public methods */


    /* Private methods */

    private void build_extra_constraints (Gtk.ConstraintLayout layout_manager)
    {
        layout_manager.add_constraint (new Gtk.Constraint (
            this._thumbnail,
            Gtk.ConstraintAttribute.TOP,
            Gtk.ConstraintRelation.EQ,
            this._thumbnail,
            Gtk.ConstraintAttribute.WIDTH,
            -0.28125, 125, Gtk.ConstraintStrength.REQUIRED
        ));
        layout_manager.add_constraint (new Gtk.Constraint (
            this._thumbnail,
            Gtk.ConstraintAttribute.BOTTOM,
            Gtk.ConstraintRelation.EQ,
            this._thumbnail,
            Gtk.ConstraintAttribute.WIDTH,
            0.28125, 125, Gtk.ConstraintStrength.REQUIRED
        ));
    }

    /* End private methods */


    /* GObject blocks */

    construct
    {
        // FIXME: This thing is hardcoded, it should be loaded from an URL
        this._thumbnail.set_resource ("/com/github/nahuelwexd/Replay/maxresdefault.jpg");

        this.build_extra_constraints ((Gtk.ConstraintLayout) this.layout_manager);
    }

    static construct
    {
        set_css_name ("videocarouselitem");
    }

    /* End GObject blocks */
}
