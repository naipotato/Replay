/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/app/drey/Replay/ui/PlayerView.ui")]
sealed class Rpy.PlayerView : Adw.NavigationPage {
    private uint           _osd_source             = 0;
    private Graphene.Point _current_mouse_position = Graphene.Point.zero ();
    private uint           _inhibition_cookie      = 0;
    private int            _n_presses              = 0;

    [GtkChild]
    private unowned Player _player;

    public string?         video_id   { get; construct; }
    public PlayerViewModel view_model { get; construct; }

    public PlayerView (string title, string video_id, PlayerViewModel? view_model = null) {
        Object (title: title, video_id: video_id, view_model: view_model ?? new PlayerViewModel ());
    }

    static construct {
        set_css_name ("rpyplayerview");

        add_binding (Gdk.Key.J, 0, (widget) => {
            var self = (PlayerView) widget;
            self._player.seek (-10 * TimeSpan.SECOND, true);
        }, null);

        add_binding (Gdk.Key.K, 0, (widget) => {
            var self = (PlayerView) widget;
            self.toggle_playback ();
        }, null);

        add_binding (Gdk.Key.L, 0, (widget) => {
            var self = (PlayerView) widget;
            self._player.seek (10 * TimeSpan.SECOND, true);
        }, null);

        add_binding_action (Gdk.Key.F, 0, "window.toggle-fullscreen", null);
        add_binding_action (Gdk.Key.F11, 0, "window.toggle-fullscreen", null);
        add_binding_action (Gdk.Key.Escape, 0, "window.unfullscreen", null);
    }

    protected override void dispose () {
        if (this._osd_source != 0)
            Source.remove (this._osd_source);

        if (this._inhibition_cookie != 0) {
            var app = Application.get_default () as App;
            app.uninhibit (this._inhibition_cookie);
        }

        base.dispose ();
    }

    protected override void shown () {
        this.view_model.fetch_video_details.begin (this.video_id);
    }

    [GtkCallback]
    private void handle_playback_status_change () {
        var app = Application.get_default () as App;

        if (this._player.playing && this._inhibition_cookie == 0)
            this._inhibition_cookie = app.inhibit (app.active_window, IDLE, _("Playing video"));

        if (!this._player.playing && this._inhibition_cookie != 0) {
            app.uninhibit (this._inhibition_cookie);
            this._inhibition_cookie = 0;
        }

        if (this._player.playing)
            this.register_timeout_to_hide_osd ();

        if (!this._player.playing)
            this.show_osd ();
    }

    [GtkCallback]
    private void handle_pointer_move (double x, double y) {
        if (!this._player.playing)
            return;

        var new_mouse_position = Graphene.Point () {
            x = (float) x,
            y = (float) y,
        };

        if (new_mouse_position.equal (this._current_mouse_position))
            return;

        this._current_mouse_position = new_mouse_position;

        this.show_osd ();
        this.register_timeout_to_hide_osd ();
    }

    [GtkCallback]
    private void handle_primary_click_released (int n_press) {
        this._n_presses = n_press;

        if (n_press == 2) {
            var window = this.root as Gtk.Window;
            window.fullscreened = !window.fullscreened;
        }
    }

    [GtkCallback]
    private void handle_primary_click_stopped () {
        if (this._n_presses == 1 && this._player.playing) {
            this.show_osd ();
            this.register_timeout_to_hide_osd ();
        }
    }

    [GtkCallback]
    private void handle_secondary_click () {
        this.toggle_playback ();
    }

    [GtkCallback]
    private bool should_be_visible (bool fullscreened) {
        return fullscreened ? false : true;
    }

    [GtkCallback]
    private bool should_spin (ViewModelState state, bool is_buffering) {
        return state == IN_PROGRESS || is_buffering;
    }

    private void show_osd () {
        if (this._osd_source != 0) {
            Source.remove (this._osd_source);
            this._osd_source = 0;
        }

        if (this.has_css_class ("hide-osd"))
            this.remove_css_class ("hide-osd");

        this._player.set_cursor_from_name (null);
    }

    private void register_timeout_to_hide_osd () {
        if (this._osd_source != 0) {
            Source.remove (this._osd_source);
            this._osd_source = 0;
        }

        this._osd_source = Utils.timeout_add_seconds_once<PlayerView> (this, 5, (self) => {
            self._osd_source = 0;

            if (!self._player.playing)
                return;

            self.add_css_class ("hide-osd");
            self._player.set_cursor_from_name ("none");
        });
    }

    private void toggle_playback () {
        if (this._player.playing)
            this._player.pause ();
        else
            this._player.play ();
    }
}
