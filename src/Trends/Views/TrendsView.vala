/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/app/drey/Replay/ui/TrendsView.ui")]
sealed class Rpy.TrendsView : Adw.NavigationPage {
    public TrendsViewModel view_model { get; construct; }

    public TrendsView () {
        Object (view_model: new TrendsViewModel ());
    }

    [GtkCallback]
    private string state_to_nick (ViewModelState state) {
        var local_state = state == INITIAL
            ? ViewModelState.IN_PROGRESS
            : state;

        return local_state.to_nick ();
    }
}
