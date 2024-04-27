// Copyright 2022 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

[GtkTemplate (ui = "/app/drey/Replay/ui/trends-view.ui")]
sealed class Rpy.TrendsView : Adw.NavigationPage {
    public TrendsViewModel view_model { get; construct; }

    public TrendsView (TrendsViewModel? view_model = null) {
        Object (view_model: view_model ?? new DefaultTrendsViewModel ());
    }

    static construct {
        set_css_name ("rpytrendsview");
    }

    protected override void constructed () {
        base.constructed ();
        this.view_model.fetch_trending_videos ().disown ();
    }

    [GtkCallback]
    private string state_to_nick (ViewModelState state) {
        if (state == ViewModelState.INITIAL) {
            state = ViewModelState.IN_PROGRESS;
        }

        return state.to_nick ();
    }
}
