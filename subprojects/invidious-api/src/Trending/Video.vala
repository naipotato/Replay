// Copyright 2023 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: LGPL-3.0-or-later

public class Iv.Video : Object {
    public string? author          { get; set; }
    public string? authorId        { get; set; }
    public string? authorUrl       { get; set; }
    public string? description     { get; set; }
    public string? descriptionHtml { get; set; }
    public int32   lengthSeconds   { get; set; }
    public bool    liveNow         { get; set; }
    public bool    paid            { get; set; }
    public bool    premium         { get; set; }
    public int64   published       { get; set; }
    public string? publishedText   { get; set; }
    public string? title           { get; set; }
    public string? videoId         { get; set; }
    public int64   viewCount       { get; set; }

    public Gee.List<Thumbnail> videoThumbnails {
        get;
        default = new Gee.ArrayList<Thumbnail> ();
    }
}

public class Iv.Thumbnail : Object {
    public string? quality { get; set; }
    public string? url     { get; set; }
    public int32   width   { get; set; }
    public int32   height  { get; set; }
}
