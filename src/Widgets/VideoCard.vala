/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/app/drey/Replay/ui/VideoCard.ui")]
sealed class Rpy.VideoCard : Gtk.Widget {
    [GtkChild]
    private unowned Gtk.Overlay _thumbnail_overlay;

    [GtkChild]
    private unowned Gtk.Grid _info_grid;

    public string?   author           { get; set; }
    public TimeSpan  duration         { get; set; }
    public DateTime? publication_date { get; set; }
    public string?   thumbnail_uri    { get; set; }
    public string?   title            { get; set; }
    public int64     view_count       { get; set; }

    protected override void dispose () {
        this._thumbnail_overlay.unparent ();
        this._info_grid.unparent ();
        base.dispose ();
    }

    [GtkCallback]
    private string? format_absolute_date (DateTime? date) {
        return date?.to_local ()?.format ("%c");
    }

    [GtkCallback]
    private string format_duration (TimeSpan duration) {
        return Utils.format_timespan (duration);
    }

    [GtkCallback]
    private string format_relative_date (DateTime? date) {
        return Utils.format_relative_date (date ?? new DateTime.now ());
    }

    [GtkCallback]
    private string format_view_count (int64 view_count) {
        var view_count_formatted = Utils.format_number (view_count, "compact-short .#");
        return ngettext ("%s view", "%s views", (long) view_count).printf (view_count_formatted);
    }
}
