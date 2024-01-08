// Copyright 2022 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

sealed class Rpy.VideoRepository {
    public async Gee.List<Video> trending () throws Error {
        var client = new Iv.Client ("invidious.fdn.fr");

        Iv.TrendingRequest request    = client.trending ();
        Gee.List<Iv.Video> api_videos = yield request.execute_async ();

        Gee.Iterator<Video> iterator = api_videos
            .iterator ()
            .map<Video> ((item) => Video.from_api (item));

        var video_list = new Gee.ArrayList<Video> ();
        video_list.add_all_iterator (iterator);

        return video_list;
    }
}
