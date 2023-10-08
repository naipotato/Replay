/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.Navigator : Gtk.Widget {
    private Adw.NavigationView _navigation_view = new Adw.NavigationView ();

    construct {
        this.layout_manager = new Gtk.BinLayout ();
        this._navigation_view.set_parent (this);
    }

    public static Navigator? current (Gtk.Widget widget) {
        return (Navigator?) widget.get_ancestor (typeof (Navigator));
    }

    public void push (View view) {
        this._navigation_view.push (view);
    }

    public void pop () {
        this._navigation_view.pop ();
    }

    public override void dispose () {
        this._navigation_view.unparent ();
        base.dispose ();
    }
}
