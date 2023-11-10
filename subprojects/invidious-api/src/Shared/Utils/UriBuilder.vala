/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

private class Iv.UriBuilder {
    private string _scheme;

    private Gee.Map<string, string> _query_params = new Gee.HashMap<string, string> ();

    public string? host     { private get; set; }
    public int?    port     { private get; set; }
    public string? path     { private get; set; }
    public string? fragment { private get; set; }

    public UriBuilder (string scheme) {
        this._scheme = scheme;
    }

    public UriBuilder add_query_param (string key, string @value) {
        this._query_params[key] = @value;
        return this;
    }

    public Uri build () {
        string? query_params = null;
        if (!this._query_params.is_empty) {
            query_params = this._query_params
                .map<string> ((param) => Uri.escape_string (@"$(param.key)=$(param.value)", "=,"))
                .fold<string> ((param, str) => str == "" ? param : @"$str&$param", "");
        }

        return Uri.build (NONE, this._scheme, null, this._host, this._port ?? -1, this.path ?? "", query_params,
            this.fragment);
    }
}
