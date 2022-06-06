/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace Iv.Functions {
    public string value_to_string (Value @value) {
        var value_type = @value.type ();

        if (value_type.is_enum ()) {
            return EnumClass.to_string (value_type, @value.get_enum ());
        }

        switch (value_type) {
            case Type.BOOLEAN:
                return @value.get_boolean ().to_string ();

            case Type.CHAR:
                return @value.get_schar ().to_string ();

            case Type.UCHAR:
                return @value.get_uchar ().to_string ();

            case Type.INT:
                return @value.get_int ().to_string ();

            case Type.UINT:
                return @value.get_uint ().to_string ();

            case Type.LONG:
                return @value.get_long ().to_string ();

            case Type.ULONG:
                return @value.get_ulong ().to_string ();

            case Type.INT64:
                return @value.get_int64 ().to_string ();

            case Type.UINT64:
                return @value.get_uint64 ().to_string ();

            case Type.FLOAT:
                return @value.get_float ().to_string ();

            case Type.DOUBLE:
                return @value.get_double ().to_string ();

            case Type.STRING:
                return @value.get_string ();
        }

        return value_type.name ();
    }
}
