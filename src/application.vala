/* application.vala
 *
 * Copyright 2019-2021 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Rpy.Application : Gtk.Application {
	public Application () {
		Object (
#if DEVEL
			// In development builds, force the resource base path to be the
			// same as the one we use in release builds, so as not to have to
			// manually load icons, shortcut window, and other automatic
			// resources, avoiding future headaches
			resource_base_path: "/com/github/replaydev/Replay",
#endif
			application_id: Constants.APPLICATION_ID,
			flags: ApplicationFlags.FLAGS_NONE
		);
	}

	public static int main (string[] args) {
		// Configure project localizations
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


		/// TRANSLATORS: This is the application name
		Environment.set_application_name (_("Replay"));


		// Since this is a media app, inform GTK that we prefer the dark theme
		Gtk.Settings? gtk_settings = Gtk.Settings.get_default ();
		assert (gtk_settings != null);

		gtk_settings.gtk_application_prefer_dark_theme = true;


		// Load our custom stylesheet
		var css_provider = new Gtk.CssProvider ();
		css_provider.load_from_resource ("/com/github/replaydev/Replay/style.css");

		Gdk.Display? display = Gdk.Display.get_default ();
		assert (display != null);

		Gtk.StyleContext.add_provider_for_display (display, css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);


		// FIXME: This call may be replaced by AdwApplication
		//        https://gitlab.gnome.org/GNOME/libadwaita/-/issues/30#note_1004873
		Adw.init ();


		// Register app actions
		var about_action = new SimpleAction ("about", null);
		about_action.activate.connect (this.show_about_dialog);
		this.add_action (about_action);

		var quit_action = new SimpleAction ("quit", null);
		quit_action.activate.connect (this.quit);
		this.set_accels_for_action ("app.quit", { "<Primary>Q" });
		this.add_action (quit_action);


		new ApplicationWindow (this);
	}

	private void show_about_dialog () requires (this.active_window != null) {
		var about_dialog = new Gtk.AboutDialog () {
			transient_for = this.active_window,
			modal = true,
			destroy_with_parent = true,
			/// TRANSLATORS: This is the title of the About dialog
			title = _("About Replay"),
			logo_icon_name = Constants.APPLICATION_ID,
			version = Constants.VERSION,
			/// TRANSLATORS: This is the summary of the app
			comments = _("Explore and watch YouTube videos"),
			website = "httos://github.com/ReplayDev/Replay",
			/// TRANSLATORS: This is the label of the link to the app's repository
			website_label = _("Project repository"),
			copyright = "© 2019 - 2020 Nahuel Gomez Castro",
			license_type = Gtk.License.GPL_3_0,
			authors = { "Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>" },
			artists = { "Noëlle https://github.com/jannuary" }
		};

		about_dialog.present_with_time (Gdk.CURRENT_TIME);
	}
}
