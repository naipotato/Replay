/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public sealed class Iv.TrendingRequest : Request<Gee.List<TrendingVideo>> {
    private string _host;
    private string? _category;
    private string? _region;

    public string? category {
        get { return this._category; }
        set {
            this._category = value;

            if (value == null) {
                this.remove_parameter ("type");
                return;
            }

            this.append_parameter ("type", value);
        }
    }

    public string? region {
        get { return this._region; }
        set {
            this._region = value;

            if (value == null) {
                this.remove_parameter ("region");
                return;
            }

            this.append_parameter ("region", value);
        }
    }

    protected override string host {
        get { return this._host; }
    }

    protected override string path {
        get { return "/api/v1/trending"; }
    }

    public TrendingRequest (InvidiousApi api_client, string host) {
        base (api_client);
        this._host = host;
    }

    protected override Gee.List<TrendingVideo> parse_response (GJson.Node json) {
        var result = GJson.deserialize_array<TrendingVideo> (json.as_array ());
        return result.read_only_view;
    }
}
