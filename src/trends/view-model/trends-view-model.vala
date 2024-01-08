// Copyright 2022 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

interface Rpy.TrendsViewModel : ViewModel {
    public abstract VideoRepository repository { get; construct; }
    public abstract ListStore       videos     { get; }

    public abstract Dex.Future fetch_trending_videos ();
}

sealed class Rpy.DefaultTrendsViewModel : ViewModel, TrendsViewModel {
    public VideoRepository repository { get; construct; }
    public ListStore       videos     { get; default = new ListStore (typeof (Video)); }

    public DefaultTrendsViewModel (VideoRepository? repository = null) {
        Object (repository: repository ?? new DefaultVideoRepository ());
    }

    public Dex.Future fetch_trending_videos () {
        return Dex.Scheduler.get_default ().spawn (0, this.fetch_trending_videos_fiber);
    }

    private Dex.Future? fetch_trending_videos_fiber () {
        this.state = ViewModelState.IN_PROGRESS;

        Gee.List<Video> videos;

        try {
            videos = (Gee.List<Video>) this.repository.trending ().await_object ();
        } catch (Error err) {
            this.state = ViewModelState.ERROR;
            return new Dex.Future.for_error (err);
        }

        Video[] videos_array = videos.to_array ();
        this.videos.splice (0, 0, videos_array);

        this.state = ViewModelState.SUCCESS;

        return null;
    }
}
