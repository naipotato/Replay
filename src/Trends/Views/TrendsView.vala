/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/app/drey/Replay/ui/TrendsView.ui")]
sealed class Rpy.TrendsView : Adw.NavigationPage {
    public TrendsViewModel view_model { get; construct; }

    public TrendsView (TrendsViewModel? view_model = null) {
        Object (view_model: view_model ?? new TrendsViewModel ());
    }

    protected override void shown () {
        this.view_model.fetch_trending_videos.begin ();
    }

    [GtkCallback]
    private string state_to_nick (ViewModelState state) {
        var local_state = state == INITIAL
            ? ViewModelState.IN_PROGRESS
            : state;

        return local_state.to_nick ();
    }

    [GtkCallback]
    private void open_video (uint position) {
        var video = this.view_model.videos.get_item (position) as CommonVideo;

        var navigator = this.get_ancestor (typeof (Adw.NavigationView)) as Adw.NavigationView;
        navigator.push (new PlayerView (video.title, video.id));
    }
}
