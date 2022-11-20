/*
 * Copyright 2019 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

/**
 * Base class for the Replay app.
 *
 * It initializes the app, registers the global actions, and starts the main
 * loop.
 */
sealed class Rpy.Application : Adw.Application {
    construct {
        this.application_id = Config.APPLICATION_ID;
    }

    public static int main (string[] args) {
        // Configure project localizations
        // See https://docs.gtk.org/glib/i18n.html
        Intl.bindtextdomain (Config.GETTEXT_PACKAGE, Config.LOCALEDIR);
        Intl.bind_textdomain_codeset (Config.GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (Config.GETTEXT_PACKAGE);

        return new Application ().run (args);
    }

    public override void activate () {
        this.active_window?.present ();
    }

    public override void startup () {
        // Ensure that the resource base path in development builds is the same
        // as in release builds to avoid problems with automatic resources.
        this.resource_base_path = "/app/drey/Replay";

        base.startup ();

        Environment.set_application_name ("Replay");

        // Since this is a media app, inform the system that we prefer a dark
        // color scheme
        this.style_manager.color_scheme = PREFER_DARK;

        this.setup_actions ();

        new MainWindow (this);
    }

    /** Sets app-level actions, along with their keyboard shortcuts */
    private void setup_actions () {
        var action_entries = new ActionEntry[] {
            { "about", show_about_window },
            { "quit",  quit              },
        };

        this.add_action_entries (action_entries, this);
        this.set_accels_for_action ("app.quit", { "<Ctrl>Q" });
    }

    /** Shows the About window */
    private void show_about_window () {
        var about_window = new Adw.AboutWindow () {
            transient_for       = this.active_window,
            modal               = true,
            destroy_with_parent = true,
            application_icon    = Config.APPLICATION_ID,
            application_name    = "Replay",
            developer_name      = "Nahuel Gomez",
            version             = Config.VERSION,
            website             = "https://github.com/nahuelwexd/Replay",
            issue_url           = "https://github.com/nahuelwexd/Replay/issues",
            developers          = { "Nahuel Gomez https://nahuelwexd.com" },
            artists             = { "Noëlle https://github.com/jannuary" },
            // TRANSLATORS: Put your credits here
            translator_credits  = _("translator-credits"),
            copyright           = "© 2022 Nahuel Gomez",
            license_type        = GPL_3_0,
        };

        about_window.present ();
    }
}
