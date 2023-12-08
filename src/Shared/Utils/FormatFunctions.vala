/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace Rpy.Utils {
    string format_number (int64 number, string skeleton) {
        var ec = Icu.ErrorCode.ZERO_ERROR;

        var uskeleton  = Icu.String.from_utf8 (skeleton, -1, ref ec);
        var uformatter = Icu.NumberFormatter.open_for_skeleton_and_locale (uskeleton, -1, null, ref ec);

        var uresult = Icu.FormattedNumber.open (ref ec);
        uformatter.format_int (number, uresult, ref ec);

        var ustring = uresult.to_string (ref ec);
        var @string = ustring.to_utf8 (-1, ref ec);

        if (ec.failure ())
            warning (@"An error ocurred when formatting number '$number'");

        return @string;
    }

    string format_relative_date (DateTime date) {
        var now        = new DateTime.now_local ();
        var local_date = date.to_local ();
        var difference = now.difference (local_date);

        if (difference < TimeSpan.MINUTE)
            return _("just now");

        if (difference < TimeSpan.HOUR) {
            var minutes = (ulong) (difference / TimeSpan.MINUTE);
            return ngettext ("%lu minute ago", "%lu minutes ago", minutes).printf (minutes);
        }

        if (difference < TimeSpan.DAY) {
            var day_hour  = now.get_hour ();
            var threshold = 24 * 0.2;

            var hours = (long) (difference / TimeSpan.HOUR);

            var was_yesterday     = day_hour - hours < 0;
            var should_be_precise = hours < threshold;

            if (was_yesterday && !should_be_precise)
                return _("yesterday");

            return ngettext ("%lu hour ago", "%lu hours ago", hours).printf (hours);
        }

        if (difference < TimeSpan.DAY * 7) {
            var week_day  = now.get_day_of_week ();
            var threshold = 7 * 0.2;

            var days = week_day - local_date.get_day_of_week ();

            var was_last_week     = days <= 0;
            var should_be_precise = days.abs () < threshold;

            if (was_last_week && !should_be_precise)
                return _("last week");

            return ngettext ("yesterday", "%i days ago", days.abs ()).printf (days.abs ());
        }

        if (difference < TimeSpan.DAY * 30) {
            var month_week = get_week_of_month (now);
            var threshold  = get_weeks_of_month (now) * 0.2;

            var weeks = month_week - get_week_of_month (local_date);

            var was_last_month    = weeks <= 0;
            var should_be_precise = weeks.abs () < threshold;

            if (was_last_month && !should_be_precise)
                return _("last month");

            return ngettext ("last week", "%i weeks ago", weeks.abs ()).printf (weeks.abs ());
        }

        if (difference < TimeSpan.DAY * 365) {
            var year_month = now.get_month ();
            var threshold  = 12 * 0.2;

            var months = year_month - local_date.get_month ();

            var was_last_year     = months <= 0;
            var should_be_precise = months.abs () < threshold;

            if (was_last_year && !should_be_precise)
                return _("last year");

            return ngettext ("last month", "%i months ago", months.abs ()).printf (months.abs ());
        }

        var years = now.get_year () - local_date.get_year ();
        return ngettext ("last year", "%i years ago", years).printf (years);
    }

    string format_timespan (TimeSpan timespan, bool always_show_hour = false) {
        var seconds = timespan % TimeSpan.MINUTE / TimeSpan.SECOND;
        var minutes = timespan % TimeSpan.HOUR   / TimeSpan.MINUTE;
        var hours   = timespan                   / TimeSpan.HOUR;

        var format          = "%02" + int64.FORMAT;
        var minutes_seconds = (format + "∶" + format).printf (minutes, seconds);

        return hours <= 0 && !always_show_hour ? minutes_seconds : @"$hours∶$minutes_seconds";
    }

    int get_week_of_month (DateTime date) {
        var first_day = new DateTime.local (date.get_year (), date.get_month (), 1, 0, 0, 0);
        var first_day_missing_days = first_day.get_day_of_week ();

        return (date.get_day_of_month () + first_day_missing_days) / 7;
    }

    int get_weeks_of_month (DateTime date) {
        var first_day = new DateTime.local (date.get_year (), date.get_month (), 1, 0, 0, 0);
        var last_day  = first_day.add_months (1).add_days (-1);

        var first_week_missing_days = first_day.get_day_of_week ();
        var last_week_missing_days  = 7 - last_day.get_day_of_week ();

        var month_with_missing_days = last_day.get_day_of_month () +
            first_week_missing_days +
            last_week_missing_days;

        return (int) Math.ceil (month_with_missing_days / 7.0);
    }
}
