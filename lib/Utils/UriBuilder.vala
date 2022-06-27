/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Iv.UriBuilder {
    private Regex _placeholder_regex = /\{(\w+)\}/;

    private string _scheme;
    private string? _userinfo;
    private string? _host;
    private int _port = -1;
    private string? _path;
    private StringBuilder? _query_builder;
    private string? _fragment;

    public string? userinfo {
        set { this._userinfo = value; }
    }

    public string? host {
        set { this._host = value; }
    }

    public int port {
        set { this._port = value; }
    }

    public string? path {
        set {
            if (value == null) {
                this._path = null;
                return;
            }

            this._path = value.has_prefix ("/") ? value : @"/$value";
        }
    }

    public string? query {
        set {
            if (value == null) {
                this._query_builder = null;
                return;
            }

            var query_with_ampersand = value.has_suffix ("&") ? value : @"$value&";

            if (this._query_builder == null) {
                this._query_builder = new StringBuilder (query_with_ampersand);
                return;
            }

            this._query_builder.assign (query_with_ampersand);
        }
    }

    public UriBuilder (string scheme) {
        this._scheme = scheme;
    }

    public UriBuilder append_parameter (string key, string value) {
        if (this._query_builder == null) {
            this._query_builder = new StringBuilder ();
        }

        this._query_builder.append (@"$key=$value&");

        return this;
    }

    public Uri build () {
        return Uri.build (
            UriFlags.NONE,
            this._scheme,
            this._userinfo,
            this._host,
            this._port,
            this._path ?? "",
            this._query_builder?.str,
            this._fragment
        );
    }

    public UriBuilder set_path_segment (string key, string value) {
        var path = this._path ?? "";

        try {
            this._placeholder_regex.replace_eval (path, -1, 0, 0, (info, res) => {
                var match = info.fetch (1);

                if (match != key) {
                    return false;
                }

                res.append (value);

                return true;
            });
        } catch (Error err) {
            warning (@"Error replacing path segment: $(err.message)");
        }

        return this;
    }
}
