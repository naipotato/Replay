/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

public class Iv.TrendingRequest : Request<Gee.List<CommonVideo>> {
    private Client _client;

    private Category? _category;
    private string    _region = "US";

    public Category? category {
        get { return this._category; }
        set {
            if (this._category == value)
                return;

            if (this._category != null)
                this.remove_query_param ("type");

            this._category = value;

            if (this._category != null)
                this.add_query_param ("type", value.as_string ());
        }
    }

    public enum Category {
        MUSIC, GAMING, NEWS, MOVIES;

        internal string as_string () {
            return enum_as_string (typeof (Category), this);
        }
    }

    public string region {
        get { return this._region; }
        set {
            if (this._region == value.up ())
                return;

            if (this._region != "US")
                this.remove_query_param ("region");

            this._region = value.up ();

            if (this._region != "US")
                this.add_query_param ("region", value.up ());
        }
    }

    internal TrendingRequest (Client client) {
        this._client = client;
    }

    internal override string host {
        get { return this._client.instance; }
    }

    internal override string path {
        get { return "/api/v1/trending"; }
    }

    internal override Soup.Session session () {
        return this._client.session;
    }

    internal override Gee.List<CommonVideo> parse_response (GJson.Node json) {
        return GJson.deserialize_array (json.as_array ());
    }
}
