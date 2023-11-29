/*
 * Copyright 2019 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.App : Adw.Application {
    public App () {
        Object (
            application_id: Config.APP_ID,

            // Ensure that the resource base path in development builds is the
            // same as in stable builds to avoid problems with automatic
            // resources
            resource_base_path: "/app/drey/Replay"
        );
    }

    public override void activate () {
        var window = this.active_window ?? new AppWindow (this);
        window.present ();
    }

    public override void startup () {
        base.startup ();

        Environment.set_application_name ("Replay");
        this.style_manager.color_scheme = PREFER_DARK;

        this.add_action_entries ({
            { "about", this.show_about_window },
            { "quit",  this.quit              },
        }, this);

        this.set_accels_for_action ("app.quit", { "<Ctrl>Q" });
    }

    private void show_about_window () {
        var about_window = new Adw.AboutWindow () {
            transient_for       = this.active_window,
            application_icon    = Config.APP_ID,
            application_name    = "Replay",
            developer_name      = "Nahuel Gomez",
            version             = Config.VERSION,
            website             = "https://github.com/nahuelwexd/Replay",
            issue_url           = "https://github.com/nahuelwexd/Replay/issues",
            developers          = { "Nahuel Gomez https://nahuelwexd.com" },
            artists             = { "Noëlle https://github.com/jannuary" },
            // TRANSLATORS: Put your credits here
            translator_credits  = _("translator-credits"),
            copyright           = "© 2023 Nahuel Gomez",
            license_type        = GPL_3_0,
        };

        about_window.present ();
    }
}
