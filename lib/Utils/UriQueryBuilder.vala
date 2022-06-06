/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public sealed class Iv.UriQueryBuilder {
    private StringBuilder _builder;

    public UriQueryBuilder (string? query = null) {
        this._builder = new StringBuilder (query);
    }

    public UriQueryBuilder append (string key, string value) {
        if (this._builder.len > 0) {
            this._builder.append_c ('&');
        }

        this._builder.append (Uri.escape_string (key));
        this._builder.append_c ('=');
        this._builder.append (Uri.escape_string (value));

        return this;
    }

    public string to_string () {
        return this._builder.str;
    }
}
