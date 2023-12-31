// Copyright 2022 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

enum Rpy.ViewModelState {
    INITIAL, IN_PROGRESS, SUCCESS, ERROR;

    public string to_nick () {
        var enumc = (EnumClass) typeof (ViewModelState).class_ref ();
        return enumc.get_value (this).value_nick;
    }
}

sealed class Rpy.TrendsViewModel : Object {
    public ViewModelState state { get; private set; default = INITIAL; }
    public ListStore trending_videos { get; default = new ListStore (typeof (Video)); }

    construct {
        this.load_trending_videos.begin ();
    }

    public async void load_trending_videos () {
        this.state = IN_PROGRESS;

        try {
            var repo = new VideoRepository ();
            var videos = yield repo.get_trending_videos ();

            var videos_array = videos.to_array ();
            this.trending_videos.splice (0, 0, (Object[]) videos_array);

            this.state = SUCCESS;
        } catch (Error e) {
            this.state = ERROR;
        }
    }
}
