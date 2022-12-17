/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

abstract class Rpy.View : Gtk.Widget, Gtk.Buildable {
    private Gtk.HeaderBar _headerbar = new Gtk.HeaderBar () {
        css_classes = { "flat" },
    };

    private Adw.Bin _content_bin = new Adw.Bin () {
        vexpand     = true,
        css_classes = { "card" },
        overflow    = HIDDEN,
    };

    public Gtk.Widget child {
        get { return this._content_bin.child; }
        set { this._content_bin.child = value; }
    }

    public ViewModel view_model { get; construct; }

    construct {
        this.layout_manager = new Gtk.BoxLayout (VERTICAL);

        this._headerbar.set_parent (this);
        this._content_bin.set_parent (this);

        this.css_classes = { "rpy-view" };
    }

    public void add_child (Gtk.Builder builder, Object child, string? type) {
        if (!(child is Gtk.Widget))
            base.add_child (builder, child, type);

        this.child = (Gtk.Widget) child;
    }

    public override void dispose () {
        this._headerbar.unparent ();
        this._content_bin.unparent ();

        base.dispose ();
    }
}
