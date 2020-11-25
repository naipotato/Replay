/* Replay - Explore and watch YouTube videos
 * Copyright 2019 - 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * Replay is free software: you can redistribute it and/or modify it under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * Replay is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Replay.  If not, see <https://www.gnu.org/licenses/>.
 */

public class Replay.Application : Gtk.Application
{
    public Application ()
    {
        Object (
            application_id: Constants.APPLICATION_ID,
            flags:          ApplicationFlags.FLAGS_NONE
        );
    }


    public override void activate ()
        requires (this.active_window != null)
    {
        this.active_window.present_with_time (Gdk.CURRENT_TIME);
    }

    public override void startup ()
    {
        base.startup ();

        // Translators: This is the application name
        Environment.set_application_name (_("Replay"));

        // Since this is a media app, it should use the dark theme
        Gtk.Settings gtk_settings = Gtk.Settings.get_default ();
        gtk_settings.gtk_application_prefer_dark_theme = true;

        var css_provider = new Gtk.CssProvider ();
        css_provider.load_from_resource (@"$(Constants.RESOURCE_PATH)/styles.css");
        Gtk.StyleContext.add_provider_for_display (
            Gdk.Display.get_default (),
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );

        Hdy.init ();

        this.init_types ();
        this.populate_actions ();

#if DEVEL
        // Load custom icons
        Gtk.IconTheme default_theme = Gtk.IconTheme.get_for_display (Gdk.Display.get_default ());
        default_theme.add_resource_path (@"$(Constants.RESOURCE_PATH)/icons");
#endif

        new ApplicationWindow (this);
    }


    private void init_types ()
    {
        typeof (HeaderBar).ensure ();
        typeof (HomePage).ensure ();
        typeof (StackSidebar).ensure ();
        typeof (VideoCarouselItem).ensure ();
    }

    private void populate_actions ()
    {
        var action = new SimpleAction ("about", null);
        action.activate.connect (parameter => {
            string[] authors = { "Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>" };

            Gtk.show_about_dialog (
                this.active_window,
                "modal", true,
                "destroy-with-parent", true,
                "title", "About Replay",
                "logo-icon-name", Constants.APPLICATION_ID,
                "version", Constants.VERSION,
                // Translators: This is a little summary about the application
                "comments", _("Explore and watch YouTube videos"),
                "website", Constants.PACKAGE_URL,
                // Translators: This is the label shown for the project repository hyperlink
                "website-label", _("Project repository"),
                "copyright", "© 2019-2020 Nahuel Gomez Castro",
                "license-type", Gtk.License.GPL_3_0,
                "authors", authors
            );
        });
        this.add_action (action);

        action = new SimpleAction ("quit", null);
        action.activate.connect (parameter => this.quit ());
        this.set_accels_for_action ("app.quit", { "<Primary>Q" });
        this.add_action (action);
    }
}
