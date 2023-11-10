/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

namespace Iv {
    private string? enum_as_string (Type enum_type, int @value) {
        var klass = (EnumClass) enum_type.class_ref ();
        unowned var eval = klass.get_value (@value);
        return eval?.value_nick.replace ("-", "_");
    }
}
