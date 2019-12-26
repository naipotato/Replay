using Gdk;
using Gtk;

namespace Unitube {

    public class App : Gtk.Application {

        private AppTheme _requested_theme;

        public AppTheme requested_theme {
            get {
                return this._requested_theme;
            }
            set {
                var gtk_settings = Gtk.Settings.get_default ();
                var settings = SettingsService.get_default ();

                gtk_settings.gtk_application_prefer_dark_theme = value == AppTheme.DARK;
                gtk_settings.gtk_theme_name = settings.system.gtk_theme.replace ("-dark", "");

                this._requested_theme = value;
            }
        }

        public bool without_colored_styles {
            get {
                var settings = SettingsService.get_default ();
                return settings.system.gtk_theme != "Adwaita" &&
                    settings.system.gtk_theme != "Adwaita-dark";
            }
        }

        public App () {
            Object (
                application_id: Config.APP_ID,
                flags: ApplicationFlags.FLAGS_NONE
            );

            this.add_actions ();
        }

        public static int main (string[] args) {
            Hdy.init (ref args);

            var app = new Unitube.App ();
            return app.run (args);
        }

        protected override void activate () {
            var icon_theme = Gtk.IconTheme.get_default ();
            icon_theme.add_resource_path (@"$(Config.RESOURCE_PATH)/icons");

            this.load_custom_styles ("style.css");

            var settings = SettingsService.get_default ();
            settings.appearance.notify["app-theme"].connect (this.on_app_theme_changed);
            settings.system.notify["gtk-theme"].connect (this.on_app_theme_changed);

            // Due to the fact that there's no way to emit the property changed
            // signal every time it gets connected to a method, I've to emit it
            // manually in order to avoid code repetition.
            settings.appearance.notify_property ("app-theme");

            var win = this.active_window;

            if (win == null) {
                win = new MainWindow (this);
                win.show ();
            }

            win.present ();
        }

        private void add_actions () {
            var about_action = new SimpleAction ("about", null);
            about_action.activate.connect (() => {
                var about_dialog = new Unitube.AboutDialog ();
                about_dialog.transient_for = this.active_window;
                about_dialog.present ();
            });
            this.add_action (about_action);

            var quit_action = new SimpleAction ("quit", null);
            quit_action.activate.connect (() => {
                this.quit ();
            });
            this.set_accels_for_action ("app.quit", {"<Ctrl>Q"});
            this.add_action (quit_action);
        }

        private void load_custom_styles (string style) {
            var screen = Screen.get_default ();

            var provider = new CssProvider ();
            provider.load_from_resource (@"$(Config.RESOURCE_PATH)/$style");

            // TODO: I've stolen this from gnome-games, but I don't know why
            // the priority is 600, I've to research more about this.
            StyleContext.add_provider_for_screen (screen, provider, 600);
        }

        private void on_app_theme_changed () {
            var settings = SettingsService.get_default ();
            var dark_theme = false;

            // Check if the system theme is dark
            dark_theme = settings.system.gtk_theme.contains ("-dark");

            // Check if the user has forced the dark theme in settings.ini
            dark_theme = settings.system.dark_theme ? true : dark_theme;

            // Check the theme setted by the user
            if (settings.appearance.app_theme != ElementTheme.SYSTEM) {
                dark_theme = settings.appearance.app_theme == ElementTheme.DARK;
            }

            // Notify that the without-colored-styles property needs to be
            // regetted
            notify_property ("without-colored-styles");

            requested_theme = dark_theme ? AppTheme.DARK : AppTheme.LIGHT;
        }
    }
}
