// Copyright 2022 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

interface Rpy.VideoRepository : Object {
    public abstract Dex.Future trending ();
}

sealed class Rpy.DefaultVideoRepository : Object, VideoRepository {
    public Dex.Future trending () {
        return Dex.Scheduler.get_default ().spawn (0, this.trending_fiber);
    }

    private Dex.Future? trending_fiber () {
        var client                 = new Iv.Client ("invidious.fdn.fr");
        Iv.TrendingRequest request = client.trending ();

        Gee.List<Iv.Video> api_videos;

        try {
            api_videos = (Gee.List<Iv.Video>) request.execute ().await_pointer ();
        } catch (Error err) {
            return new Dex.Future.for_error (err);
        }

        Gee.Iterator<Video> iterator = api_videos
            .iterator ()
            .map<Video> ((item) => Video.from_api (item));

        var video_list = new Gee.ArrayList<Video> ();
        video_list.add_all_iterator (iterator);

        return new Dex.Future.for_object (video_list);
    }
}
