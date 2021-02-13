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

public class Rpy.Application : Gtk.Application {
	public Application () {
		Object (
#if DEVEL
			// In development builds, we force the resource base path to be the
			// same as that of release builds, to not have to manually load the
			// icons, shortcuts window and other automatic resources, avoiding
			// future headaches.
			resource_base_path: Constants.RESOURCE_PATH,
#endif
			application_id: Constants.APPLICATION_ID,
			flags: ApplicationFlags.FLAGS_NONE
		);
	}


	public static int main (string[] args) {
		// See https://developer.gnome.org/glib/stable/glib-I18N.html#glib-I18N.description
		Intl.setlocale (LocaleCategory.ALL);
		Intl.bindtextdomain (Constants.GETTEXT_PACKAGE, Constants.LOCALEDIR);
		Intl.bind_textdomain_codeset (Constants.GETTEXT_PACKAGE, "UTF-8");
		Intl.textdomain (Constants.GETTEXT_PACKAGE);

		return new Rpy.Application ().run (args);
	}


	public override void activate () requires (this.active_window != null) {
		this.active_window.present_with_time (Gdk.CURRENT_TIME);
	}

	public override void startup () {
		base.startup ();

		// Translators: This is the application name
		Environment.set_application_name (_("Replay"));

		// Since this is a media app, the dark theme is used
		Gtk.Settings? gtk_settings = Gtk.Settings.get_default ();
		if (gtk_settings != null) {
			gtk_settings.gtk_application_prefer_dark_theme = true;
		}

		var css_provider = new Gtk.CssProvider ();
		css_provider.load_from_resource (@"$(Constants.RESOURCE_PATH)/styles.css");

		Gdk.Display? display = Gdk.Display.get_default ();
		if (display != null) {
			Gtk.StyleContext.add_provider_for_display (display, css_provider,
				Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
		}

		Adw.init ();

		this.ensure_type_registration ();
		this.register_actions ();

		new ApplicationWindow (this);
	}


	private void ensure_type_registration () {
		typeof (HeaderBar).ensure ();
		typeof (HomePage).ensure ();
		typeof (StackSidebar).ensure ();
		typeof (VideoCarouselItem).ensure ();
	}

	private void register_actions () {
		var about_action = new SimpleAction ("about", null);
		about_action.activate.connect (parameter => this.show_about_dialog ());
		this.add_action (about_action);

		var quit_action = new SimpleAction ("quit", null);
		quit_action.activate.connect (parameter => this.quit ());
		this.set_accels_for_action ("app.quit", { "<Primary>Q" });
		this.add_action (quit_action);
	}

	private void show_about_dialog () requires (this.active_window != null) {
		var about_dialog = new Gtk.AboutDialog () {
			transient_for = this.active_window,
			modal = true,
			destroy_with_parent = true,
			// Translators: This is the title of the About dialog
			title = _("About Replay"),
			logo_icon_name = Constants.APPLICATION_ID,
			version = Constants.VERSION,
			// Translators: This is the summary of the app
			comments = _("Explore and watch YouTube videos"),
			website = Constants.PROJECT_WEBSITE,
			// Translators: This is the label of the link to the app's repository
			website_label = _("Project repository"),
			copyright = "© 2019 - 2020 Nahuel Gomez Castro",
			license_type = Gtk.License.GPL_3_0,
			authors = { "Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>" }
		};

		about_dialog.present_with_time (Gdk.CURRENT_TIME);
	}
}
