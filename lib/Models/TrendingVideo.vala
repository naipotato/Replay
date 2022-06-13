/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public sealed class Iv.TrendingVideo : Object {
    public string? title { get; set; }
    public string? videoId { get; set; }

    public Gee.List<VideoThumbnail> videoThumbnails {
        get;
        default = new Gee.ArrayList<VideoThumbnail> ();
    }

    public int32 lengthSeconds { get; set; }
    public int64 viewCount { get; set; }
    public string? author { get; set; }
    public string? authorId { get; set; }
    public string? authorUrl { get; set; }
    public int64 published { get; set; }
    public string? publishedText { get; set; }
    public string? description { get; set; }
    public string? descriptionHtml { get; set; }
    public bool liveNow { get; set; }
    public bool paid { get; set; }
    public bool premium { get; set; }
}
