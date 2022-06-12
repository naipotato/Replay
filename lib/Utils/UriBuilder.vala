/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Iv.UriBuilder {
    private string _scheme;
    private string? _userinfo;
    private string? _host;
    private int _port = -1;
    private StringBuilder? _path_builder;
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
                this._path_builder = null;
                return;
            }

            var path_with_slash = value.has_prefix ("/")
                ? value
                : "/%s".printf (value);

            if (this._path_builder == null) {
                this._path_builder = new StringBuilder (path_with_slash);
                return;
            }

            this._path_builder.assign (path_with_slash);
        }
    }

    public string? query {
        set {
            if (value == null) {
                this._query_builder = null;
                return;
            }

            var query_with_ampersand = value.has_suffix ("&")
                ? value
                : "%s&".printf (value);

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

    public UriBuilder append_path (string new_segment) {
        if (this._path_builder == null) {
            this._path_builder = new StringBuilder ();
        }

        this._path_builder.append_printf ("/%s", new_segment);

        return this;
    }

    public UriBuilder append_query_param (string key, string value) {
        if (this._query_builder == null) {
            this._query_builder = new StringBuilder ();
        }

        this._query_builder.append_printf ("%s=%s&", key, value);

        return this;
    }

    public Uri build () {
        return Uri.build (
            UriFlags.NONE,
            this._scheme,
            this._userinfo,
            this._host,
            this._port,
            this._path_builder?.str ?? "",
            this._query_builder?.str,
            this._fragment
        );
    }
}
