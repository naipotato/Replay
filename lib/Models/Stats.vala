/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public sealed class Iv.Stats : Object {
    public string? version { get; set; }
    public Software? software { get; set; }

    public sealed class Software : Object {
        public string? name { get; set; }
        public string? version { get; set; }
        public string? branch { get; set; }
    }

    public bool openRegistrations { get; set; }
    public Usage? usage { get; set; }

    public sealed class Usage : Object {
        public Users users { get; set; }

        public sealed class Users : Object {
            public int32 total { get; set; }
            public int32 activeHalfYear { get; set; }
            public int32 activeMonth { get; set; }
        }
    }

    public Metadata metadata { get; set; }

    public sealed class Metadata : Object {
        public int64 updatedAt { get; set; }
        public int64 lastChannelRefreshedAt { get; set; }
    }
}
