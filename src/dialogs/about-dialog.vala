class UniTube.AboutDialog : Gtk.AboutDialog {

	construct {
		this.destroy_with_parent = true;
		this.modal = true;

		this.authors = { "Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>" };

		this.program_name = "UniTube";
		this.comments = "An open source client for YouTube";
		this.copyright = "Copyright © 2019 Nucleux Software";
		this.version = "0.1.0";

		this.license_type = Gtk.License.GPL_3_0;

		this.website = "https://github.com/NucleuxSoft/unitube-gtk";
	}
}
