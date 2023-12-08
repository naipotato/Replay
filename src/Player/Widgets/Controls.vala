/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/app/drey/Replay/ui/Controls.ui")]
sealed class Rpy.Controls : Gtk.Widget {
    private Player? _player = null;

    [GtkChild]
    private unowned Gtk.Button _skip_backwards_button;

    [GtkChild]
    private unowned Gtk.Button _play_pause_replay_button;

    [GtkChild]
    private unowned Gtk.Button _skip_forward_button;

    [GtkChild]
    private unowned Gtk.Label _position_label;

    [GtkChild]
    private unowned Gtk.Scale _scale;

    [GtkChild]
    private unowned Gtk.Label _duration_label;

    [GtkChild]
    private unowned Gtk.Button _fullscreen_button;

    public Player? player {
        get { return this._player; }
        set {
            if (this._player == value)
                return;

            if (this._player != null)
                this._player.notify["position"].disconnect (this.update_position);

            this._player = value;

            if (this._player != null)
                this._player.notify["position"].connect (this.update_position);
        }
    }

    static construct {
        set_css_name ("rpycontrols");
    }

    protected override void dispose () {
        if (this.player != null)
            this.player.notify["position"].disconnect (this.update_position);

        this._skip_backwards_button.unparent ();
        this._play_pause_replay_button.unparent ();
        this._skip_forward_button.unparent ();
        this._position_label.unparent ();
        this._scale.unparent ();
        this._duration_label.unparent ();
        this._fullscreen_button.unparent ();

        base.dispose ();
    }

    [GtkCallback]
    private string duration_to_string (TimeSpan duration) {
        return Utils.format_timespan (duration);
    }

    [GtkCallback]
    private void handle_css_classes_changed () {
        if (this._scale.has_css_class ("dragging"))
            this.player.pause ();
        else
            this.player.play ();
    }

    [GtkCallback]
    private void handle_play_pause_replay_button_clicked () {
        if (this.player.stopped) {
            this.player.seek (0);
            return;
        }

        if (this.player.playing)
            this.player.pause ();
        else
            this.player.play ();
    }

    [GtkCallback]
    private void handle_skip_backwards_button_clicked () {
        if (this.player != null && !this._scale.has_css_class ("dragging"))
            this.player.seek (-10 * TimeSpan.SECOND, true);
    }

    [GtkCallback]
    private void handle_skip_forward_button_clicked () {
        if (this.player != null && !this._scale.has_css_class ("dragging"))
            this.player.seek (10 * TimeSpan.SECOND, true);
    }

    [GtkCallback]
    private void handle_value_changed () {
        if (this.player != null && this._scale.has_css_class ("dragging"))
            this.player.seek ((TimeSpan) Math.round (this._scale.get_value ()));
    }

    [GtkCallback]
    private string icon_name_from_fullscreen_status (bool fullscreened) {
        return fullscreened ? "rpy-restore-symbolic" : "rpy-fullscreen-symbolic";
    }

    [GtkCallback]
    private string icon_name_from_playback_status (bool playing, bool stopped) {
        if (stopped)
            return "rpy-replay-symbolic";

        return playing ? "rpy-pause-symbolic" : "rpy-play-symbolic";
    }

    [GtkCallback]
    private string position_to_string (TimeSpan position, TimeSpan duration) {
        return Utils.format_timespan (position, duration / TimeSpan.HOUR > 0);
    }

    [GtkCallback]
    private string tooltip_from_fullscreen_status (bool fullscreened) {
        return fullscreened ? _("Exit Fullscreen") : _("Fullscreen");
    }

    [GtkCallback]
    private string tooltip_from_playback_status (bool playing, bool stopped) {
        if (stopped)
            return _("Replay");

        return playing ? _("Pause") : _("Play");
    }

    private void update_position () {
        if (this.player != null && !this._scale.has_css_class ("dragging"))
            this._scale.set_value (this.player.position);
    }
}
