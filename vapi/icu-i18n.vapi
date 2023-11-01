/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[CCode (cprefix = "U", lower_case_cprefix = "u_")]
namespace Icu {
    [CCode (cheader_filename = "unicode/utypes.h", cprefix = "U_", default_value = "U_ZERO_ERROR")]
    public enum ErrorCode {
        ZERO_ERROR, BUFFER_OVERFLOW_ERROR;

        [CCode (cname = "U_FAILURE")]
        public bool failure ();
    }

    [SimpleType]
    [IntegerType (rank = 4)]
    [CCode (cheader_filename = "unicode/umachine.h")]
    public struct Char {}

    [Compact]
    [Immutable]
    [CCode (cheader_filename = "unicode/umachine.h", cname = "UChar", const_cname = "const UChar", free_function = "g_free")]
    public class String {
        [CCode (cname = "u_strFromUTF8")]
        private static unowned String? _from_utf8 (String? dest, int32 dest_capacity, out int32 p_dest_length, string src, int32 src_length, ref ErrorCode p_error_code);

        [CCode (cname = "_vala_u_strFromUTF8")]
        public static String from_utf8 (string src, int32 src_length, ref ErrorCode p_error_code) {
            int32 length;
            String._from_utf8 (null, 0, out length, src, src_length, ref p_error_code);

            if (p_error_code == BUFFER_OVERFLOW_ERROR)
                p_error_code = ZERO_ERROR;

            var dest = (String) new Char[length + 1];
            String._from_utf8 (dest, length + 1, null, src, src_length, ref p_error_code);

            return dest;
        }

        [CCode (cname = "u_strToUTF8", instance_pos = 3.1)]
        private unowned string? _to_utf8 (string? dest, int32 dest_capacity, out int32 p_dest_length, int32 src_length, ref ErrorCode p_error_code);

        [CCode (cname = "_vala_u_strToUTF8")]
        public string to_utf8 (int32 src_length, ref ErrorCode p_error_code) {
            int32 length;
            this._to_utf8 (null, 0, out length, src_length, ref p_error_code);

            if (p_error_code == BUFFER_OVERFLOW_ERROR)
                p_error_code = ZERO_ERROR;

            var dest = (string) new char[length + 1];
            this._to_utf8 (dest, length + 1, null, src_length, ref p_error_code);

            return dest;
        }
    }

    [Compact]
    [CCode (cheader_filename = "unicode/unumberformatter.h", free_function = "unumf_closeResult")]
    public class FormattedNumber {
        [CCode (cname = "unumf_openResult")]
        public static FormattedNumber? open (ref ErrorCode ec);

        [CCode (cname = "unumf_resultToString")]
        private int32 _to_string (String? buffer, int32 buffer_capacity, ref ErrorCode ec);

        [CCode (cname = "_vala_unumf_resultToString")]
        public String to_string (ref ErrorCode ec) {
            var length = this._to_string (null, 0, ref ec);

            if (ec == BUFFER_OVERFLOW_ERROR)
                ec = ZERO_ERROR;

            var dest = (String) new Char[length + 1];
            this._to_string (dest, length + 1, ref ec);

            return dest;
        }
    }

    [Compact]
    [CCode (cheader_filename = "unicode/unumberformatter.h", free_function = "unumf_close")]
    public class NumberFormatter {
        [CCode (cname = "unumf_openForSkeletonAndLocale")]
        public static NumberFormatter? open_for_skeleton_and_locale (String skeleton, int32 skeleton_len, string? locale, ref ErrorCode ec);

        [CCode (cname = "unumf_formatInt")]
        public void format_int (int64 @value, FormattedNumber uresult, ref ErrorCode ec);
    }
}
