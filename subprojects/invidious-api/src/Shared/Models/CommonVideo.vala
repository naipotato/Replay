/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

public class Iv.CommonVideo : Object {
    public string? author            { get; set; }
    public string? authorId          { get; set; }
    public string? authorUrl         { get; set; }
    public bool    authorVerified    { get; set; }
    public string? description       { get; set; }
    public string? descriptionHtml   { get; set; }
    public bool    isUpcoming        { get; set; }
    public int64   lengthSeconds     { get; set; }
    public bool    liveNow           { get; set; }
    public int64   premiereTimestamp { get; set; }
    public bool    premium           { get; set; }
    public int64   published         { get; set; }
    public string? publishedText     { get; set; }
    public string? title             { get; set; }
    public string? videoId           { get; set; }
    public int64   viewCount         { get; set; }
    public string? viewCountText     { get; set; }

    public Gee.List<CommonThumbnail> videoThumbnails {
        get;
        default = new Gee.ArrayList<CommonThumbnail> ();
    }
}
