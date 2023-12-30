// Copyright 2022 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

sealed class Rpy.VideoRepository {
    public async Gee.List<Video> get_trending_videos () throws Error {
        var client = new Iv.Client ("invidious.fdn.fr");

        var request    = client.trending ();
        var api_videos = yield request.execute_async ();

        var it = api_videos.iterator ().map<Video> ((item) => this.api_to_video (item));

        var video_list = new Gee.ArrayList<Video> ();
        video_list.add_all_iterator (it);

        return video_list;
    }

    private Video api_to_video (Iv.Video api_video) {
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
