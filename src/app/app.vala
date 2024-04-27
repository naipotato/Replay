// Copyright 2019 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

sealed class Rpy.App : Adw.Application {
    public App (string app_id) {
        Object (application_id: app_id);
    }

    public static int main (string[] args) {
        var app = new App (Config.APP_ID);
        return app.run (args);
    }

    protected override void activate () {
        (this.active_window ?? new AppWindow (this)).present ();
    }

    protected override void startup () {
        // See https://docs.gtk.org/glib/i18n.html
        Intl.bindtextdomain (Config.GETTEXT_PKG, Config.LOCALEDIR);
        Intl.bind_textdomain_codeset (Config.GETTEXT_PKG, "UTF-8");
        Intl.textdomain (Config.GETTEXT_PKG);

        Application.set_default (this);
        this.resource_base_path = "/app/drey/Replay";

        base.startup ();
        Dex.init ();

        Environment.set_application_name ("Replay");

        var style_manager = Adw.StyleManager.get_default ();
        style_manager.color_scheme = Adw.ColorScheme.PREFER_DARK;

        this.add_action_entries (new ActionEntry[] {
            ActionEntry () {
                name     = "about",
                activate = this.show_about_window,
            },
            ActionEntry () {
                name     = "quit",
                activate = this.quit,
            },
        }, this);

        this.set_accels_for_action ("app.quit", new string[] { "<Ctrl>Q" });
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
