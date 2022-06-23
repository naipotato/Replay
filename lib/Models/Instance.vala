/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public sealed class Iv.Instance : Object {
    public string? flag { get; set; }
    public string? region { get; set; }
    public Stats? stats { get; set; }
    public bool cors { get; set; }
    public bool api { get; set; }

    [Description (nick = "json::type")]
    public string? protocol { get; set; }

    public string? uri { get; set; }
    public Monitor? monitor { get; set; }

    public sealed class Monitor : Object {
        public int64 monitorId { get; set; }
        public int64 createdAt { get; set; }
        public string? statusClass { get; set; }
        public string? name { get; set; }
        public string? url { get; set; }

        [Description (nick = "json::type")]
        public string? protocol { get; set; }

        public Gee.List<Ratio> dailyRatios {
            get;
            default = new Gee.ArrayList<Ratio> ();
        }

        [Description (nick = "json::90dRatio")]
        public Ratio? ninetyDayRatio { get; set; }

        [Description (nick = "json::30dRatio")]
        public Ratio? thirtyDayRatio { get; set; }

        public sealed class Ratio : Object {
            public string? ratio { get; set; }
            public string? label { get; set; }
        }
    }
}
