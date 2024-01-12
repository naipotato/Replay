// Copyright 2022 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

interface Rpy.TrendsViewModel : ViewModel {
    public abstract VideoRepository repository { get; construct; }
    public abstract ListStore       videos     { get; }

    public abstract async void fetch_trending_videos ();
}

sealed class Rpy.DefaultTrendsViewModel : ViewModel, TrendsViewModel {
    public VideoRepository repository { get; construct; }
    public ListStore       videos     { get; default = new ListStore (typeof (Video)); }

    public DefaultTrendsViewModel (VideoRepository? repository = null) {
        Object (repository: repository ?? new DefaultVideoRepository ());
    }

    public async void fetch_trending_videos () {
        this.state = ViewModelState.IN_PROGRESS;

        try {
            Gee.List<Video> videos = yield this.repository.trending ();

            Video[] videos_array = videos.to_array ();
            this.videos.splice (0, 0, videos_array);

            this.state = ViewModelState.SUCCESS;
        } catch {
            this.state = ViewModelState.ERROR;
        }
    }
}
