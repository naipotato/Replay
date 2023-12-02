/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.TrendsViewModel : ViewModel {
    public VideoRepository repository { get; construct; }
    public ListStore videos { get; default = new ListStore (typeof (Video)); }

    public TrendsViewModel (VideoRepository? repository = null) {
        Object (repository: repository ?? new VideoRepository ());
    }

    public async void fetch_trending_videos () {
        this.state = IN_PROGRESS;

        try {
            var videos = yield this.repository.get_trending_videos ();

            var videos_array = videos.to_array ();
            this.videos.splice (0, 0, (Object[]) videos_array);

            this.state = SUCCESS;
        } catch {
            this.state = ERROR;
        }
    }
}
