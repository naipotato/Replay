/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/app/drey/Replay/ui/VideoItem.ui")]
sealed class Rpy.VideoItem : Gtk.Widget {
    [GtkChild]
    private unowned Gtk.Overlay _thumbnail_overlay;

    [GtkChild]
    private unowned Gtk.Grid _info_grid;

    public string?   thumbnail_uri    { get; set; }
    public string?   title            { get; set; }
    public string?   author           { get; set; }
    public int64     view_count       { get; set; }
    public DateTime? publication_date { get; set; }
    public TimeSpan  duration         { get; set; }

    protected override void dispose () {
        this._thumbnail_overlay.unparent ();
        this._info_grid.unparent ();
        base.dispose ();
    }

    [GtkCallback]
    private string format_view_count (int64 view_count) {
        var ec = Icu.ErrorCode.ZERO_ERROR;
        view_count = view_count.clamp (0, long.MAX);

        var uskeleton = Icu.String.from_utf8 ("K .#", -1, ref ec);
        var uformatter = Icu.NumberFormatter.open_for_skeleton_and_locale (uskeleton, -1, null, ref ec);

        var uresult = Icu.FormattedNumber.open (ref ec);
        uformatter.format_int (view_count, uresult, ref ec);

        var ustring = uresult.to_string (ref ec);
        var @string = ustring.to_utf8 (-1, ref ec);

        if (ec.failure ())
            warning ("An error ocurred when formatting view count");

        return ngettext ("%s view", "%s views", (long) view_count).printf (@string);
    }

    [GtkCallback]
    private string format_relative_date (DateTime? date) {
        if (date == null)
            return _("just now");

        var local_date = date.to_local ();
        var now = new DateTime.now_local ();
        var difference = now.difference (local_date);

        if (difference < TimeSpan.MINUTE)
            return _("just now");

        if (difference < TimeSpan.HOUR) {
            var minutes = (ulong) (difference / TimeSpan.MINUTE);
            return ngettext ("%lu minute ago", "%lu minutes ago", minutes).printf (minutes);
        }

        if (difference < TimeSpan.DAY) {
            var day_hour = now.get_hour ();
            var threshold = 24 * 0.2;

            var hours = (long) (difference / TimeSpan.HOUR);

            var was_yesterday = day_hour - hours < 0;
            var should_be_precise = hours < threshold;

            if (was_yesterday && !should_be_precise)
                return _("yesterday");

            return ngettext ("%lu hour ago", "%lu hours ago", hours).printf (hours);
        }

        if (difference < TimeSpan.DAY * 7) {
            var week_day = now.get_day_of_week ();
            var threshold = 7 * 0.2;

            var days = week_day - local_date.get_day_of_week ();

            var was_last_week = days <= 0;
            var should_be_precise = days.abs () < threshold;

            if (was_last_week && !should_be_precise)
                return _("last week");

            return ngettext ("yesterday", "%i days ago", days.abs ()).printf (days.abs ());
        }

        if (difference < TimeSpan.DAY * 30) {
            var month_week = this.get_week_of_month (now);
            var threshold = this.get_weeks_of_month (now) * 0.2;

            var weeks = month_week - this.get_week_of_month (local_date);

            var was_last_month = weeks <= 0;
            var should_be_precise = weeks.abs () < threshold;

            if (was_last_month && !should_be_precise)
                return _("last month");

            return ngettext ("last week", "%i weeks ago", weeks.abs ()).printf (weeks.abs ());
        }

        if (difference < TimeSpan.DAY * 365) {
            var year_month = now.get_month ();
            var threshold = 12 * 0.2;

            var months = year_month - local_date.get_month ();

            var was_last_year = months <= 0;
            var should_be_precise = months.abs () < threshold;

            if (was_last_year && !should_be_precise)
                return _("last year");

            return ngettext ("last month", "%i months ago", months.abs ()).printf (months.abs ());
        }

        var years = now.get_year () - local_date.get_year ();
        return ngettext ("last year", "%i years ago", years).printf (years);
    }

    private int get_weeks_of_month (DateTime date) {
        var first_day = new DateTime.local (date.get_year (), date.get_month (), 1, 0, 0, 0);
        var last_day = first_day.add_months (1).add_days (-1);

        var first_week_missing_days = first_day.get_day_of_week ();
        var last_week_missing_days = 7 - last_day.get_day_of_week ();

        var month_with_missing_days = last_day.get_day_of_month () +
            first_week_missing_days +
            last_week_missing_days;

        return (int) Math.ceil (month_with_missing_days / 7.0);
    }

    private int get_week_of_month (DateTime date) {
        var first_day = new DateTime.local (date.get_year (), date.get_month (), 1, 0, 0, 0);
        var first_day_missing_days = first_day.get_day_of_week ();

        return (date.get_day_of_month () + first_day_missing_days) / 7;
    }

    [GtkCallback]
    private string? format_absolute_date (DateTime? date) {
        return date?.to_local ()?.format ("%c");
    }

    [GtkCallback]
    private string format_duration (TimeSpan duration) {
        var seconds = duration % TimeSpan.MINUTE / TimeSpan.SECOND;
        var minutes = duration % TimeSpan.HOUR / TimeSpan.MINUTE;
        var hours   = duration / TimeSpan.HOUR;

        return hours <= 0
            ? "%02lli∶%02lli".printf (minutes, seconds)
            : "%lli∶%02lli∶%02lli".printf (hours, minutes, seconds);
    }
}
