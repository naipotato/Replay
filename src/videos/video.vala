// Copyright 2022 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

sealed class Rpy.Video : Object {
    public string?   id               { get; set; }
    public string?   thumbnail_uri    { get; set; }
    public string?   title            { get; set; }
    public string?   author           { get; set; }
    public int64     view_count       { get; set; }
    public DateTime? publication_date { get; set; }
    public TimeSpan  duration         { get; set; }

    public static Video from_api (Iv.Video api_video) {
        return new Video () {
            id               = api_video.videoId,
            thumbnail_uri    = api_video.videoThumbnails[0].url,
            title            = api_video.title,
            author           = api_video.author,
            view_count       = api_video.viewCount,
            publication_date = new DateTime.from_unix_utc (api_video.published),
            duration         = api_video.lengthSeconds * TimeSpan.SECOND,
        };
    }
}
