/* Replay - An open source YouTube client for GNOME
 * Copyright (C) 2019 - 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * Replay is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Replay is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Replay.  If not, see <https://www.gnu.org/licenses/>.
 */

class App : Gtk.Application {

    public static Utlib.Client client { get; private set; }

    static construct {
        client = new Utlib.Client () {
            api_key = Constants.API_KEY
        };
    }

    public App () {
        Object (
            application_id: Constants.APPLICATION_ID,
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    private static int main (string[] args) {
        Intl.setlocale (LocaleCategory.ALL);
        Intl.bindtextdomain (Constants.GETTEXT_PACKAGE, Constants.LOCALEDIR);
        Intl.bind_textdomain_codeset (Constants.GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (Constants.GETTEXT_PACKAGE);

        var app = new App ();
        return app.run (args);
    }

    protected override void startup () {
        base.startup ();

        Gtk.Window.set_default_icon_name (Constants.APPLICATION_ID);
        Environment.set_prgname (Constants.APPLICATION_ID);

        this.populate_actions ();
        this.init_types ();

        // Load theme from the user preferences
        new ThemesService ().update_theme (new SettingsService ().dark_theme);

#if DEVEL
        var default_theme = Gtk.IconTheme.get_for_display (Gdk.Display.get_default ());
        default_theme.add_resource_path (@"$(Constants.RESOURCE_PATH)/icons");
#endif
    }

    protected override void activate () {
        var win = this.active_window ?? new MainWindow (this);
        win.present ();
    }

    private void populate_actions () {
        var action = new SimpleAction ("about", null);
        action.activate.connect (this.on_about_activate);
        this.add_action (action);

        action = new SimpleAction ("quit", null);
        action.activate.connect (this.quit);
        this.set_accels_for_action ("app.quit", { "<Primary>Q" });
        this.add_action (action);
    }

    private void init_types () {
        typeof (MainHeaderBar).ensure ();
        typeof (TrendingView).ensure ();
        typeof (ErrorMessage).ensure ();
    }

    private void on_about_activate () {
        string[] authors = { "Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>" };

        Gtk.show_about_dialog (
            this.active_window,
            "modal", true,
            "destroy-with-parent", true,
            "license-type", Gtk.License.GPL_3_0,
            "program-name", _("Replay"),
            "logo-icon-name", Constants.APPLICATION_ID,
            "version", Constants.VERSION,
            "copyright", "Copyright © 2019-2020 Nahuel Gomez Castro",
            "authors", authors,
            "comments", _("An open source YouTube client for GNOME."),
            "website-label", _("Project repository"),
            "website", Constants.PACKAGE_URL
        );
    }
}
