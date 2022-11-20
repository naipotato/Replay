/*
 * Copyright 2019 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/app/drey/Replay/MainWindow.ui")]
class Rpy.MainWindow : Adw.ApplicationWindow {
    public MainWindow (App app) {
        Object (application: app);
    }

#if DEVEL
    construct {
        this.add_css_class ("devel");
    }
#endif
}
