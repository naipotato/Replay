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

[GtkTemplate (ui = "/com/github/nahuelwexd/Replay/video-carousel-item.ui")]
public class Rpy.VideoCarouselItem : Gtk.Widget {
	[GtkChild]
	private unowned Gtk.Picture _thumbnail;

	public string thumbnail_url { get; set; }
	public string title { get; set; }
	public string channel_title { get; set; }

	public override void snapshot (Gtk.Snapshot snapshot) {
		Graphene.Rect rect = {};
		rect.init (0, 0, this.get_width (), this.get_height ());

		Gsk.RoundedRect rounded_rect = {};
		rounded_rect.init_from_rect (rect, 6.0f);

		snapshot.push_rounded_clip (rounded_rect);

		base.snapshot (snapshot);

		snapshot.pop ();
	}

	private void build_extra_constraints (Gtk.ConstraintLayout layout_manager) {
		layout_manager.add_constraint (new Gtk.Constraint (
			this._thumbnail,
			Gtk.ConstraintAttribute.TOP,
			Gtk.ConstraintRelation.EQ,
			this._thumbnail,
			Gtk.ConstraintAttribute.WIDTH,
			-0.28125,
			125,
			Gtk.ConstraintStrength.REQUIRED
		));
		layout_manager.add_constraint (new Gtk.Constraint (
			this._thumbnail,
			Gtk.ConstraintAttribute.BOTTOM,
			Gtk.ConstraintRelation.EQ,
			this._thumbnail,
			Gtk.ConstraintAttribute.WIDTH,
			0.28125,
			125,
			Gtk.ConstraintStrength.REQUIRED
		));
	}

	construct {
		// FIXME: This thing is hardcoded, it should be loaded from an URL
		this._thumbnail.set_resource ("/com/github/nahuelwexd/Replay/maxresdefault.jpg");

		this.build_extra_constraints ((Gtk.ConstraintLayout) this.layout_manager);
	}

	static construct {
		set_css_name ("videocarouselitem");
	}
}
