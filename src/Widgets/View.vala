/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

abstract class Rpy.View : Adw.NavigationPage, Gtk.Buildable {
    private Adw.Bin _content_bin = new Adw.Bin () {
        vexpand     = true,
        css_classes = { "card" },
        overflow    = HIDDEN,
    };

    public new Gtk.Widget? child {
        get { return this._content_bin.child; }
        set { this._content_bin.child = value; }
    }

    public ViewModel view_model { get; construct; }

    construct {
        var toolbar_view = new Adw.ToolbarView () {
            content = this._content_bin,
        };

        toolbar_view.add_top_bar (new Adw.HeaderBar ());

        base.child = toolbar_view;
        this.css_classes = { "rpy-view" };
    }

    public void add_child (Gtk.Builder builder, Object child, string? type) {
        if (!(child is Gtk.Widget))
            base.add_child (builder, child, type);

        this.child = (Gtk.Widget) child;
    }
}
