/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

public class Iv.Video : Object {
    public bool    allowRatings      { get; set; }
    public string? author            { get; set; }
    public string? authorId          { get; set; }
    public string? authorUrl         { get; set; }
    public string? description       { get; set; }
    public string? descriptionHtml   { get; set; }
    public int64   dislikeCount      { get; set; }
    public string? genre             { get; set; }
    public string? genreUrl          { get; set; }
    public string? hlsUrl            { get; set; }
    public bool    isFamilyFriendly  { get; set; }
    public bool    isListed          { get; set; }
    public bool    isUpcoming        { get; set; }
    public int64   lengthSeconds     { get; set; }
    public int64   likeCount         { get; set; }
    public bool    liveNow           { get; set; }
    public bool    paid              { get; set; }
    public int64   premiereTimestamp { get; set; }
    public bool    premium           { get; set; }
    public int64   published         { get; set; }
    public string? publishedText     { get; set; }
    public double  rating            { get; set; }
    public string? subCountText      { get; set; }
    public string? title             { get; set; }
    public string? videoId           { get; set; }
    public int64   viewCount         { get; set; }

    public Gee.List<AdaptiveFormat> adaptiveFormats {
        get;
        default = new Gee.ArrayList<AdaptiveFormat> ();
    }

    public Gee.List<string> allowedRegions {
        get;
        default = new Gee.ArrayList<string> ();
    }

    public Gee.List<CommonImage> authorThumbnails {
        get;
        default = new Gee.ArrayList<CommonImage> ();
    }

    public Gee.List<Caption> captions {
        get;
        default = new Gee.ArrayList<Caption> ();
    }

    public Gee.List<FormatStream> formatStreams {
        get;
        default = new Gee.ArrayList<FormatStream> ();
    }

    public Gee.List<string> keywords {
        get;
        default = new Gee.ArrayList<string> ();
    }

    public Gee.List<VideoShort> recommendedVideos {
        get;
        default = new Gee.ArrayList<VideoShort> ();
    }

    public Gee.List<CommonThumbnail> videoThumbnails {
        get;
        default = new Gee.ArrayList<CommonThumbnail> ();
    }
}
