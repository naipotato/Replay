/*
 * Copyright 2021 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

enum Rpy.ViewType {
    PRIMARY, SECONDARY, TRANSITORY;
}

class Rpy.View : Adw.Bin {
    public string? title { get; set; }
    public string? subtitle { get; set; }
    public ViewType view_type { get; construct; }
}
