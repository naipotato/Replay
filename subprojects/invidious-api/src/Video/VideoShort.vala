/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

public class Iv.VideoShort : Object {
    public string? author        { get; set; }
    public int64   lengthSeconds { get; set; }
    public string? title         { get; set; }
    public string? videoId       { get; set; }
    public string? viewCountText { get; set; }

    public Gee.List<CommonThumbnail> videoThumbnails {
        get;
        default = new Gee.ArrayList<CommonThumbnail> ();
    }
}
