/*
 * Copyright 2019 Nahuel Gomez Castro <contact@nahuelgomez.com.ar>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/com/github/replaydev/Replay/app-window.ui")]
class Rpy.AppWindow : Adw.ApplicationWindow {
	public AppWindow (App app) {
		Object (application: app);
	}

#if DEVEL
	construct {
		this.add_css_class ("devel");
	}
#endif
}
