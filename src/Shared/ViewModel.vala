/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

abstract class Rpy.ViewModel : Object {
    public ViewModelState state { get; protected set; default = INITIAL; }
}

enum Rpy.ViewModelState {
    INITIAL, IN_PROGRESS, SUCCESS, ERROR;

    public string to_nick () {
        var enumc = (EnumClass) typeof (ViewModelState).class_ref ();
        return enumc.get_value (this).value_nick;
    }
}
