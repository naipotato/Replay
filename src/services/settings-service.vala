namespace Unitube {

    public class SettingsService : Object {

        private static GLib.Once<SettingsService> instance;

        public AppearanceSettings appearance { get; private set; }
        public SystemSettings system { get; private set; }

        private SettingsService () {
            appearance = new AppearanceSettings (@"$(Config.APP_ID).appearance");
            system = new SystemSettings ("org.gnome.desktop.interface");
        }

        public static unowned SettingsService get_default () {
            return instance.once (() => {
                return new SettingsService ();
            });
        }
    }
}
