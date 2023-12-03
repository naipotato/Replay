/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

public class Iv.VideoRequest : Request<Video> {
    private Client _client;
    private string _path;

    private string _region = "US";

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

    internal override string host {
        get { return this._client.instance; }
    }

    internal override string path {
        get { return this._path; }
    }

    internal VideoRequest (Client client, string id) {
        this._client = client;
        this._path   = @"/api/v1/videos/$id";
    }

    internal override Soup.Session session () {
        return this._client.session;
    }

    internal override Video parse_response (GJson.Node json) {
        return (Video) GJson.deserialize_object (typeof (Video), json.as_object ());
    }
}
