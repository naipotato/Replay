// Copyright 2019 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

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

    public static int main (string[] args) {
        return new App ().run (args);
    }

    protected override void activate () {
        var window = this.active_window ?? new AppWindow (this);
        window.present ();
    }

    protected override void startup () {
        // See https://docs.gtk.org/glib/i18n.html
        Intl.bindtextdomain (Config.GETTEXT_PKG, Config.LOCALEDIR);
        Intl.bind_textdomain_codeset (Config.GETTEXT_PKG, "UTF-8");
        Intl.textdomain (Config.GETTEXT_PKG);

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
        Adw.show_about_window (this.active_window,
            application_icon: Config.APP_ID,
            application_name: "Replay",
            developer_name: "Nahuel Gomez",
            version: Config.VERSION,
            website: "https://github.com/nahuelwexd/Replay",
            issue_url: "https://github.com/nahuelwexd/Replay/issues",
            developers: new string[] { "Nahuel Gomez https://nahuelwexd.com" },
            artists: new string[] { "Noëlle https://github.com/jannuary" },
            // Translators: Replace "translator-credits" with your credits
            translator_credits: _("translator-credits"),
            copyright: "© 2023 Nahuel Gomez",
            license_type: Gtk.License.GPL_3_0
        );
    }
}
