/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.TrendsViewModel : ViewModel {
    public ListStore trending_videos { get; default = new ListStore (typeof (Video)); }

    construct {
        this.load_trending_videos.begin ();
    }

    public async void load_trending_videos () {
        this.state = LOADING;

        try {
            var repo = new VideoRepository ();
            var videos = yield repo.get_trending_videos ();

            var videos_array = videos.to_array ();
            this.trending_videos.splice (0, 0, (Object[]) videos_array);

            this.state = LOADED;
        } catch (Error e) {
            this.state = ERROR;
        }
    }
}
