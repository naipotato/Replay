/*
 * Copyright 2019 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/app/drey/Replay/ui/AppWindow.ui")]
class Rpy.AppWindow : Adw.ApplicationWindow {
    [GtkChild]
    private unowned Navigator _navigator;

    public AppWindow (App app) {
        Object (application: app);
    }

    construct {
        #if DEVEL
            this.add_css_class ("devel");
        #endif
    }
}
