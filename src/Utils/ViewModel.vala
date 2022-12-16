/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

abstract class Rpy.ViewModel : Object {
    public ViewModelState state { get; protected set; default = INITIAL; }
}

enum Rpy.ViewModelState {
    INITIAL,
    LOADING,
    LOADED,
    ERROR;
}
