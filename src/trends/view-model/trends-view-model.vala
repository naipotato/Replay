// Copyright 2022 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

sealed class Rpy.TrendsViewModel : ViewModel {
    public ListStore trending_videos { get; default = new ListStore (typeof (Video)); }

    construct {
        this.load_trending_videos.begin ();
    }

    public async void load_trending_videos () {
        this.state = ViewModelState.IN_PROGRESS;

        try {
            var repository         = new VideoRepository ();
            Gee.List<Video> videos = yield repository.get_trending_videos ();

            Video[] videos_array = videos.to_array ();
            this.trending_videos.splice (0, 0, videos_array);

            this.state = ViewModelState.SUCCESS;
        } catch {
            this.state = ViewModelState.ERROR;
        }
    }
}
