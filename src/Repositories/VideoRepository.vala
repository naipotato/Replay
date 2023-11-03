/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.VideoRepository {
    public async Gee.List<Video> get_trending_videos () throws Error {
        var uri = "https://invidious.fdn.fr/api/v1/trending";

        var response = yield fetch (uri);
        var json = yield response.json ();

        if (!response.ok)
            throw HttpError.from_status_code (response.status_code, json);

        var it = json.as_array ().iterator ().map<Video> (
            (item) => this.json_to_video ((GJson.Object) item));

        var video_list = new Gee.ArrayList<Video> ();
        video_list.add_all_iterator (it);

        return video_list;
    }

    private Video json_to_video (GJson.Object json) {
        var video = new Video () {
            id            = json["videoId"].as_string (),
            thumbnail_uri = json["videoThumbnails"][0]["url"].as_string (),
            title         = json["title"].as_string (),
            author        = json["author"].as_string (),
            view_count    = json["viewCount"].as_integer (),
        };

        var publication_date_unix = json["published"].as_integer ();
        video.publication_date = new DateTime.from_unix_utc (publication_date_unix);

        var duration_seconds = json["lengthSeconds"].as_integer ();
        video.duration = duration_seconds * TimeSpan.SECOND;

        return video;
    }
}
