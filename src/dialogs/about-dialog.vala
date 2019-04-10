class UniTube.AboutDialog : Gtk.AboutDialog {

    public AboutDialog (Gtk.Window window) {
        this.transient_for = window;
    }

	construct {
		this.destroy_with_parent = true;
		this.modal = true;

		this.authors = { "Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>" };

		this.logo_icon_name = "com.nucleuxsoft.UniTube";
		this.program_name = "UniTube";
		this.comments = "An open source client for YouTube built in GTK.";
		this.copyright = "Copyright © 2019 Nucleux Software";
		this.version = "0.1.0";

		this.license_type = Gtk.License.GPL_3_0;

        this.website = "https://github.com/NucleuxSoft/unitube-gtk";

        this.response.connect (() => {
            this.hide ();
        });

        this.hide.connect (() => {
            this.destroy ();
        });
	}
}
