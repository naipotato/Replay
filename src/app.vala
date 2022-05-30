/*
 * Copyright 2019 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

class Rpy.App : Adw.Application {
    App () {
        Object (
#if DEVEL
            // Ensure that the resource base path in development builds is the same
            // as in release builds to avoid problems with automatic resources.
            resource_base_path: "/app/drey/Replay",
#endif
            application_id: Constants.APPLICATION_ID,
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    // FIXME: We're able to access instance members, but not explicitly
    ActionEntry[] action_entries = {
        { "about", show_about_dialog },
        { "quit",  quit              }
    };

    static int main (string[] args) {
        // Configure project localizations
        // See https://developer.gnome.org/glib/stable/glib-I18N.html#glib-I18N.description
        Intl.bindtextdomain (Constants.GETTEXT_PACKAGE, Constants.LOCALEDIR);
        Intl.bind_textdomain_codeset (Constants.GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (Constants.GETTEXT_PACKAGE);

        return new App ().run (args);
    }

    protected override void activate () {
        this.active_window?.present ();
    }

    protected override void startup () {
        base.startup ();


        /// TRANSLATORS: This is the application name
        Environment.set_application_name (_("Replay"));


        // Since this is a media app, inform the system that we prefer a dark
        // color scheme
        this.style_manager.color_scheme = Adw.ColorScheme.PREFER_DARK;


        // Register app actions
        this.add_action_entries (action_entries, this);
        this.set_accels_for_action ("app.quit", { "<Ctrl>Q" });


        new AppWindow (this);
    }

    void show_about_dialog () {
        if (this.active_window == null) return;

        Gtk.show_about_dialog (
            this.active_window,
            modal: true,
            destroy_with_parent: true,
            /// TRANSLATORS: This is the title of the About dialog
            title: _("About Replay"),
            logo_icon_name: Constants.APPLICATION_ID,
            version: Constants.VERSION,
            /// TRANSLATORS: This is the summary of the app
            comments: _("Explore and watch YouTube videos"),
            website: "https://github.com/nahuelwexd/Replay",
            /// TRANSLATORS: This is the label of the link to the app's repository
            website_label: _("Project repository"),
            copyright: "© 2022 Nahuel Gomez",
            license_type: Gtk.License.GPL_3_0,
            authors: new string[] { "Nahuel Gomez https://nahuelwexd.com" },
            artists: new string[] { "Noëlle https://github.com/jannuary" }
        );
    }
}
