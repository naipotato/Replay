/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

class Rpy.Navigator : Gtk.Widget {
    private Adw.Leaflet _leaflet = new Adw.Leaflet () {
        can_navigate_back = true,
        can_unfold        = false,
    };

    construct {
        this.layout_manager = new Gtk.BinLayout ();

        this._leaflet.set_parent (this);

        this._leaflet.notify["child-transition-running"].connect (this.try_remove_screen);
        this._leaflet.notify["visible-child"].connect (this.try_remove_screen);
    }

    public static Navigator? current (Gtk.Widget widget) {
        return (Navigator?) widget.get_ancestor (typeof (Navigator));
    }

    public void push (Gtk.Widget screen) {
        if (screen.get_parent () != this._leaflet)
            this._leaflet.append (screen);

        this._leaflet.visible_child = screen;
    }

    public void pop () {
        this._leaflet.navigate (BACK);
    }

    public override void dispose () {
        this._leaflet.unparent ();
        base.dispose ();
    }

    private void try_remove_screen () {
        if (this._leaflet.child_transition_running)
            return;

        var child = this._leaflet.get_first_child ();
        while (child != null) {
            var screen = child;
            child = child.get_next_sibling ();

            if (screen == this._leaflet.visible_child)
                break;

            this._leaflet.remove (screen);
        }
    }
}
