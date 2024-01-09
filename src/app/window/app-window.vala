// Copyright 2019 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

[GtkTemplate (ui = "/app/drey/Replay/ui/app-window.ui")]
sealed class Rpy.AppWindow : Adw.ApplicationWindow {
    [GtkChild]
    private unowned Adw.NavigationView _navigation_view;

    public AppWindow (App app) {
        Object (application: app);
    }

    protected override void constructed () {
        base.constructed ();

        #if DEVEL
            this.add_css_class ("devel");
        #endif

        this._navigation_view.push (new TrendsView ());
    }
}
