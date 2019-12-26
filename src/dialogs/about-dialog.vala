namespace Unitube {

    [GtkTemplate (ui = "/com/gitlab/nahuelwexd/Unitube/ui/about-dialog.ui")]
    public class AboutDialog : Gtk.AboutDialog {

        construct {
            logo_icon_name = Config.APP_ID;
            version = Config.VERSION;
            website = Config.PACKAGE_URL;
        }
    }
}
