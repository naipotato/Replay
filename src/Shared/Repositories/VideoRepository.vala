/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.VideoRepository {
    private Iv.Client _client;

    public VideoRepository (Iv.Client? client = null) {
        this._client = client ?? new Iv.Client ("invidious.fdn.fr");
    }

    public async Gee.List<CommonVideo> trending () throws Error {
        var request    = this._client.trending ();
        var api_videos = yield request.execute_async ();

        var it = api_videos.iterator ().map<CommonVideo> ((video) => CommonVideo.from_api (video));

        var video_list = new Gee.ArrayList<CommonVideo> ();
        video_list.add_all_iterator (it);

        return video_list;
    }

    public async Video video (string id) throws Error {
        var request   = this._client.video (id);
        var api_video = yield request.execute_async ();

        return Video.from_api (api_video);
    }
}
