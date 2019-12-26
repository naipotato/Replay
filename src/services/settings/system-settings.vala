namespace Unitube {

    public class SystemSettings : Object {

        private Settings settings;
        private Gtk.Settings gtk_settings;

        public string gtk_theme { get; set; }

        private bool? _dark_theme;
        public bool dark_theme {
            get {
                _dark_theme = _dark_theme ?? gtk_settings.gtk_application_prefer_dark_theme;
                return _dark_theme;
            }
        }

        public SystemSettings (string schema) {
            settings = new Settings (schema);
            gtk_settings = Gtk.Settings.get_default ();

            settings.bind ("gtk-theme", this, "gtk-theme", SettingsBindFlags.GET);
        }
    }
}
