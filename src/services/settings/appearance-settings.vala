namespace Unitube {

    public class AppearanceSettings : Object {

        private Settings settings;

        public ElementTheme app_theme {
            get {
                var theme = settings.get_string ("app-theme");

                ElementTheme result;
                if (ElementTheme.try_parse_nick (theme, out result)) {
                    return result;
                } else {
                    return ElementTheme.SYSTEM;
                }
            }
            set {
                settings.set_string ("app-theme", value.to_nick ());
            }
        }

        public AppearanceSettings (string schema) {
            settings = new Settings (schema);

            settings.changed["app-theme"].connect (() => {
                notify_property ("app-theme");
            });
        }
    }
}
