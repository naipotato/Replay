class UniTube.App : Gtk.Application {

    public App (string app_id) {
        Object (
            application_id: app_id,
            flags: ApplicationFlags.FLAGS_NONE
        );
	}

	protected override void activate () {
		var win = this.active_window;

		if (win == null) {
			win = new MainWindow (this);
			win.show_all ();
		}

		win.present ();
	}
}
