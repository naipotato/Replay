/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace Rpy.Utils {
    Gdk.RGBA rgba_from_hex (int64 hex_code) {
        return Gdk.RGBA () {
            red   = hex_code >> 24 & 0xFF,
            green = hex_code >> 16 & 0xFF,
            blue  = hex_code >> 8  & 0xFF,
            alpha = hex_code       & 0xFF,
        };
    }
}
