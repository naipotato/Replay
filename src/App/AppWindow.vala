/*
 * Copyright 2019 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/app/drey/Replay/ui/AppWindow.ui")]
sealed class Rpy.AppWindow : Adw.ApplicationWindow {
    [GtkChild]
    private unowned Adw.NavigationView _navigation_view;

    public AppWindow (App app) {
        Object (application: app);
    }

    construct {
        #if DEVEL
            this.add_css_class ("devel");
        #endif

        this._navigation_view.push (new TrendsView ());
    }

    static construct {
        install_property_action ("window.toggle-fullscreen", "fullscreened");
        install_action ("window.unfullscreen", null, AppWindow.unfullscreen);
    }

    private new static void unfullscreen (Gtk.Widget widget) {
        var self = widget as AppWindow;
        self.fullscreened = false;
    }
}
