/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.Thumbnail : Gtk.Widget {
    private static Soup.Session _session = new Soup.Session ();

    private Gdk.Texture? _texture = null;

    private double  _aspect_ratio = 16.0 / 9.0;
    private int     _min_width    = 260;
    private string? _uri          = null;

    public double aspect_ratio {
        get { return this._aspect_ratio; }
        set {
            if (this._aspect_ratio == value)
                return;

            this._aspect_ratio = value;

            this.notify_property ("min-height");
            this.queue_resize ();
        }
    }

    public int min_height {
        get { return (int) (this.min_width / this.aspect_ratio); }
    }

    public int min_width {
        get { return this._min_width; }
        set {
            if (this._min_width == value)
                return;

            this._min_width = value;

            this.notify_property ("min-height");
            this.queue_resize ();
        }
    }

    public string? uri {
        get { return this._uri; }
        set {
            if (this._uri == value)
                return;

            this._uri = value;

            this.refresh_thumbnail.begin ();
        }
    }

    protected override Gtk.SizeRequestMode get_request_mode () {
        return HEIGHT_FOR_WIDTH;
    }

    protected override void measure (Gtk.Orientation orientation, int for_size,
        out int minimum, out int natural, out int minimum_baseline, out int natural_baseline)
    {
        minimum_baseline = natural_baseline = -1;

        minimum = natural = orientation == HORIZONTAL
            ? (int) (int.max (for_size, this.min_height) * this.aspect_ratio)
            : (int) (int.max (for_size, this.min_width)  / this.aspect_ratio);
    }

    protected override void snapshot (Gtk.Snapshot snapshot) {
        if (this._texture == null)
            return;

        var paintable_width  = this._texture.get_intrinsic_width ();
        var paintable_height = this._texture.get_intrinsic_height ();

        var widget_width  = this.get_width ();
        var widget_height = this.get_height ();

        double width, height;
        this._texture.compute_concrete_size (widget_width, 0, paintable_width,
            paintable_height, out width, out height);

        snapshot.translate (Graphene.Point () {
            x = 0,
            y = (int) (0 - (height - widget_height) / 2),
        });

        snapshot.push_clip (Graphene.Rect () {
            origin = Graphene.Point () {
                x = 0,
                y = (int) ((height - widget_height) / 2),
            },
            size   = Graphene.Size () {
                width  = widget_width,
                height = widget_height,
            },
        });

        var filter = width > paintable_width || height > paintable_height
            ? Gsk.ScalingFilter.NEAREST
            : Gsk.ScalingFilter.TRILINEAR;

        snapshot.append_scaled_texture (this._texture, filter, Graphene.Rect () {
            origin = Graphene.Point (),
            size   = Graphene.Size () {
                width  = (float) width,
                height = (float) height,
            },
        });

        snapshot.pop ();
    }

    private async void refresh_thumbnail () {
        this._texture = null;

        this.queue_draw ();
        this.queue_resize ();

        if (this.uri == null)
            return;

        try {
            var message = new Soup.Message ("GET", this.uri);
            var bytes   = yield Thumbnail._session.send_and_read_async (message, Priority.DEFAULT_IDLE, null);

            if (message.status_code >= 400)
                return;

            this._texture = yield Utils.run_in_thread (() => Gdk.Texture.from_bytes (bytes));

            this.queue_resize ();
            this.queue_draw ();
        } catch {}
    }
}
