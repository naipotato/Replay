/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.VideoRepository {
    public async Gee.List<Video> get_trending_videos () throws Error {
        var client = new Iv.Client ("invidious.fdn.fr");

        var request    = client.trending ();
        var api_videos = yield request.execute_async ();

        var it = api_videos.iterator ().map<Video> ((video) => Video.from_api (video));

        var video_list = new Gee.ArrayList<Video> ();
        video_list.add_all_iterator (it);

        return video_list;
    }
}
