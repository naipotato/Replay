/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.Thumbnail : Gtk.Widget {
    private Gdk.Paintable? _paintable;

    private string? _uri;
    private double _aspect_ratio = 16.0 / 9.0;
    private int _min_width = 260;

    public string? uri {
        get { return this._uri; }
        set {
            if (this._uri == value)
                return;

            this._uri = value;

            this.refresh_thumbnail.begin ();
        }
    }

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

    public int min_height {
        get { return (int) (this.min_width / this.aspect_ratio); }
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
        if (this._paintable == null)
            return;

        var paintable_width = this._paintable.get_intrinsic_width ();
        var paintable_height = this._paintable.get_intrinsic_height ();

        var widget_width = this.get_width ();
        var widget_height = this.get_height ();

        double width, height;
        this._paintable.compute_concrete_size (widget_width, 0, paintable_width,
            paintable_height, out width, out height);

        snapshot.translate ({ 0, (int) (0 - (height - widget_height) / 2) });

        snapshot.push_clip (Graphene.Rect () {
            origin = { 0, (int) ((height - widget_height) / 2) },
            size = { widget_width, widget_height },
        });

        var filter = width > paintable_width || height > paintable_height
            ? Gsk.ScalingFilter.NEAREST
            : Gsk.ScalingFilter.TRILINEAR;

        snapshot.append_scaled_texture ((Gdk.Texture) this._paintable, filter, Graphene.Rect () {
            origin = { 0, 0 },
            size = { (float) width, (float) height },
        });

        snapshot.pop ();
    }

    private async void refresh_thumbnail () {
        this._paintable = null;

        this.queue_draw ();
        this.queue_resize ();

        if (this.uri == null)
            return;

        try {
            var response = yield fetch (this.uri);
            var bytes = yield response.bytes ();

            if (!response.ok)
                return;

            this._paintable = yield run_in_thread (() => Gdk.Texture.from_bytes (bytes));

            this.queue_draw ();
            this.queue_resize ();

            return;
        } catch {}
    }
}
