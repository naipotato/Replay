using Gdk;
using Gtk;

namespace Unitube {

    [GtkTemplate (ui = "/com/gitlab/nahuelwexd/Unitube/ui/main-window.ui")]
    public class MainWindow : ApplicationWindow {

        [GtkChild]
        private MainHeaderBar headerbar;

        [GtkChild]
        private TrendingView trending_view;

        [GtkChild]
        private SubscriptionsView subs_view;

        [GtkChild]
        private LibraryView library_view;

        public MainWindow (App app) {
            Object (
                application: app
            );

            var close_action = new SimpleAction ("close", null);
            close_action.activate.connect (() => {
                this.close ();
            });
            app.set_accels_for_action ("win.close", {"<Ctrl>W"});
            this.add_action (close_action);
        }

        [GtkCallback]
        private bool on_key_press_event (EventKey event) {
            return headerbar.handle_event (event);
        }
    }
}
