/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/app/drey/Replay/ui/TrendsView.ui")]
sealed class Rpy.TrendsView : View {
    public TrendsView () {
        Object (view_model: new TrendsViewModel ());
    }

    [GtkCallback]
    private string state_to_nick (ViewModelState state) {
        switch (state) {
            case INITIAL:
            case LOADING:
                return "loading";

            case LOADED:
                return "loaded";

            case ERROR:
                return "error";
        }

        return "loading";
    }
}
