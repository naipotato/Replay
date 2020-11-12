/* Replay - An open source YouTube client for GNOME
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

public class Replay.App : Gtk.Application
{
    public App ()
    {
        Object (
            application_id: Constants.APPLICATION_ID,
            flags: GLib.ApplicationFlags.FLAGS_NONE
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

        // Set the app name
        // Translators: this is the application name
        GLib.Environment.set_application_name (_("Replay"));

        // Since this is a media app, it should use the dark theme
        Gtk.Settings gtk_settings = Gtk.Settings.get_default ();
        gtk_settings.gtk_application_prefer_dark_theme = true;

        // Load custom styles
        var css_provider = new Gtk.CssProvider ();
        css_provider.load_from_resource (@"$(Constants.RESOURCE_PATH)/styles.css");
        Gtk.StyleContext.add_provider_for_display (Gdk.Display.get_default (), css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        // Initialize Handy
        Hdy.init ();

        this.ensure_type_registration ();
        this.register_actions ();

#if DEVEL
        // Load custom icons
        Gtk.IconTheme default_theme = Gtk.IconTheme.get_for_display (Gdk.Display.get_default ());
        default_theme.add_resource_path (@"$(Constants.RESOURCE_PATH)/icons");
#endif

        // Get the container and instantiate the application window
        Vdi.ObjectFactory factory = Helpers.get_factory (this);
        factory.withdraw (typeof (AppWindow));
    }


    private void ensure_type_registration ()
    {
        typeof (HeaderBar).ensure ();
        typeof (StackSidebar).ensure ();
    }

    private void register_actions ()
    {
        var action = new GLib.SimpleAction ("about", null);
        action.activate.connect (parameter => this.show_about_dialog ());
        this.add_action (action);

        action = new GLib.SimpleAction ("quit", null);
        action.activate.connect (parameter => this.quit ());
        this.set_accels_for_action ("app.quit", { "<Primary>Q" });
        this.add_action (action);
    }

    private void show_about_dialog ()
        requires (this.active_window != null)
    {
        string[] authors = { "Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>" };

        Gtk.show_about_dialog (
            this.active_window,
            "modal", true,
            "destroy-with-parent", true,
            "title", _("About Replay"),
            "logo-icon-name", Constants.APPLICATION_ID,
            "version", Constants.VERSION,
            "comments", _("An open source YouTube client for GNOME"),
            "website", Constants.PACKAGE_URL,
            "website-label", _("Project repository"),
            "copyright", "© 2019-2020 Nahuel Gomez Castro",
            "license-type", Gtk.License.GPL_3_0,
            "authors", authors
        );
    }
}
