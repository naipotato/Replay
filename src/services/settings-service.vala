class UniTube.SettingsService : Object {

    private Settings _settings;

    private SettingsService () {
        this._settings = new Settings ("com.nucleuxsoft.UniTube");
    }

    public static SettingsService instance {
        owned get {
            return new SettingsService ();
        }
    }

    public Gtk.Allocation window_size {
        get {
            var rect = Gtk.Allocation ();

            this._settings.get ("window-size", "(ii)", out rect.width,
                                out rect.height);

            return rect;
        }
        set {
            this._settings.set ("window-size", "(ii)", value.width,
                                value.height);
        }
    }

    public Gdk.Rectangle window_position {
        get {
            var rect = Gdk.Rectangle ();

            this._settings.get ("window-position", "(ii)", out rect.x,
                                out rect.y);

            return rect;
        }
        set {
            this._settings.set ("window-position", "(ii)", value.x, value.y);
        }
    }

    public bool window_maximized {
        get {
            return this._settings.get_boolean ("window-maximized");
        }
        set {
            this._settings.set_boolean ("window-maximized", value);
        }
    }

    public bool dark_theme {
        get {
            return this._settings.get_boolean ("dark-theme");
        }
        set {
            this._settings.set_boolean ("dark-theme", value);
        }
    }
}
