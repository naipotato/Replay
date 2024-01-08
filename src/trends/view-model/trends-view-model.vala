// Copyright 2022 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

sealed class Rpy.TrendsViewModel : ViewModel {
    public VideoRepository repository { get; construct; }
    public ListStore       videos     { get; default = new ListStore (typeof (Video)); }

    public TrendsViewModel (VideoRepository? repository = null) {
        Object (repository: repository ?? new VideoRepository ());
    }

    construct {
        this.fetch_trending_videos.begin ();
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
