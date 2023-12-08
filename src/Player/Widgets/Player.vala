/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.Player : Gtk.Widget {
    private Gst.Bus?       _bus            = null;
    private Gdk.Paintable? _paintable      = null;
    private Gst.Element    _pipeline       = Gst.ElementFactory.make ("playbin3");
    private Gst.Query      _position_query = new Gst.Query.position (TIME);
    private Gst.State      _target_state   = PLAYING;
    private string?        _uri            = null;

    public bool     autoplay  { get; construct;   default = true;  }
    public bool     buffering { get; private set; default = false; }
    public TimeSpan duration  { get; private set; default = 0;     }
    public bool     playing   { get; private set; default = false; }
    public TimeSpan position  { get; private set; default = 0;     }
    public bool     prepared  { get; private set; default = false; }
    public bool     seekable  { get; private set; default = false; }
    public bool     stopped   { get; private set; default = false; }

    public string? uri {
        get { return this._uri; }
        set {
            if (this._uri == value)
                return;

            if (this._uri != null)
                this._pipeline.set_state (NULL);

            this._uri = value;

            if (this._uri != null) {
                this._pipeline.@set ("uri", this._uri);
                this._pipeline.set_state (PAUSED);
            }
        }
    }

    public signal void error (Error error, string debug);

    public void pause () {
        if (this.prepared && this.playing)
            this._pipeline.set_state (this._target_state = PAUSED);
    }

    public void play () {
        if (this.prepared && !this.playing)
            this._pipeline.set_state (this._target_state = PLAYING);
    }

    public void seek (TimeSpan timestamp, bool relative = false) {
        if (this.prepared && this.seekable) {
            var new_position = relative ? this.position + timestamp : timestamp;
            new_position = new_position.clamp (0, this.duration);

            this._pipeline.seek_simple (TIME, FLUSH, new_position * Gst.USECOND);
        }
    }

    protected override void constructed () {
        base.constructed ();

        var video_sink = Gst.ElementFactory.make ("gtk4paintablesink");

        video_sink.@get ("paintable", out this._paintable);
        this._paintable.invalidate_contents.connect (this.queue_draw);

        this._pipeline.@set (
            "flags", 0x697, // soft-colorbalance + deinterlace + buffering + soft-volume + text + audio + video + download
            "video-sink", video_sink
        );

        this._bus = this._pipeline.get_bus ();
        this._bus.add_signal_watch (Priority.DEFAULT_IDLE);

        this._bus.message["async-done"].connect (this.handle_async_done);
        this._bus.message["buffering"].connect (this.handle_buffering);
        this._bus.message["eos"].connect (this.handle_eos);
        this._bus.message["error"].connect (this.handle_error);
        this._bus.message["state-changed"].connect (this.handle_state_changed);

        this._target_state = this.autoplay ? Gst.State.PLAYING : Gst.State.PAUSED;

        Utils.widget_add_tick_callback (this, (widget) => {
            ((Player) widget).update_position ();
            return Source.CONTINUE;
        });
    }

    protected override void dispose () {
        this._bus?.remove_signal_watch ();
        this._pipeline.set_state (NULL);

        base.dispose ();
    }

    protected override void snapshot (Gtk.Snapshot snapshot) {
        var width  = this.get_width ();
        var height = this.get_height ();

        if (!this.stopped && this._paintable != null) {
            this._paintable.snapshot (snapshot, width, height);
            return;
        }

        var color  = Utils.rgba_from_hex (0x000000FF);
        var bounds = Graphene.Rect ().init (0, 0, width, height);

        snapshot.append_color (color, bounds);
    }

    private void handle_async_done (Gst.Message message) {
        if (message.src != this._pipeline || this.prepared)
            return;

        this.prepared = true;

        var duration_query = new Gst.Query.duration (TIME);
        var seeking_query  = new Gst.Query.seeking (TIME);

        if (this._pipeline.query (duration_query)) {
            int64 duration;
            duration_query.parse_duration (null, out duration);
            this.duration = duration / Gst.USECOND;
        }

        if (this._pipeline.query (seeking_query)) {
            bool seekable;
            seeking_query.parse_seeking (null, out seekable, null, null);
            this.seekable = seekable;
        }
    }

    private void handle_buffering (Gst.Message message) {
        int percent;
        message.parse_buffering (out percent);

        this.buffering = percent < 100;
        this._pipeline.set_state (percent >= 100 ? this._target_state : Gst.State.PAUSED);
    }

    private void handle_eos (Gst.Message message) {
        this.stopped = true;
        this.playing = false;

        this.queue_draw ();
    }

    private void handle_error (Gst.Message message) {
        Error error; string debug;
        message.parse_error (out error, out debug);

        this.error (error, debug);
        critical ("Element %s threw an error: %s\nDebugging info: %s", message.src.name, error.message, debug);

        this._pipeline.set_state (NULL);
        this.playing = false;
    }

    private void handle_state_changed (Gst.Message message) {
        if (message.src != this._pipeline)
            return;

        Gst.State new_state;
        message.parse_state_changed (null, out new_state, null);

        this.stopped = false;
        this.playing = new_state == PLAYING;
    }

    private void update_position () {
        if (!this.prepared)
            return;

        if (this._pipeline.query (this._position_query)) {
            int64 position;
            this._position_query.parse_position (null, out position);
            this.position = position / Gst.USECOND;
        }
    }
}
