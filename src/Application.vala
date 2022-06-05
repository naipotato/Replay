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

        // TRANSLATORS: This is the application name
        Environment.set_application_name (_("Replay"));

        // Since this is a media app, inform the system that we prefer a dark
        // color scheme
        this.style_manager.color_scheme = PREFER_DARK;

        this.setup_actions ();

        new AppWindow (this);
    }

    /** Sets app-level actions, along with their keyboard shortcuts */
    private void setup_actions () {
        var action_entries = new ActionEntry[] {
            { "about", show_about_dialog },
            { "quit",  quit              },
        };

        this.add_action_entries (action_entries, this);
        this.set_accels_for_action ("app.quit", { "<Ctrl>Q" });
    }

    /** Shows the About dialog */
    private void show_about_dialog () {
        var about_dialog = new Gtk.AboutDialog () {
            transient_for = this.active_window,
            modal = true,
            destroy_with_parent = true,
            // TRANSLATORS: This is the title of the About dialog
            title = C_("about window title", "About Replay"),
            logo_icon_name = Config.APPLICATION_ID,
            version = Config.VERSION,
            // TRANSLATORS: This is the summary of the app
            comments = _("Explore and watch your favorite videos"),
            website = "https://github.com/nahuelwexd/Replay",
            // TRANSLATORS: This is the label of the link to the app's repo
            website_label = _("Project repository"),
            copyright = "© 2022 Nahuel Gomez",
            license_type = GPL_3_0,
            authors = { "Nahuel Gomez https://nahuelwexd.com" },
            artists = { "Noëlle https://github.com/jannuary" },
        };

        about_dialog.present ();
    }
}
