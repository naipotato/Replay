/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public abstract class Iv.Request<TResponse> {
    private InvidiousApi _api_client;
    private Gee.List<string> _path_params = new Gee.ArrayList<string> ();

    private Gee.Map<string, string> _query_params =
        new Gee.HashMap<string, string> ();

    protected abstract string host { get; }
    protected abstract string base_path { get; }

    private Soup.Session session {
        get { return this._api_client.session; }
    }

    protected Request (InvidiousApi api_client) {
        this._api_client = api_client;
    }

    public async TResponse execute_async (Cancellable? cancellable = null)
        throws RequestError, IOError
    {
        var uri = this.build_uri ();
        var message = new Soup.Message.from_uri ("GET", uri);

        Bytes response;

        try {
            response = yield this.session.send_and_read_async (
                message,
                Priority.DEFAULT,
                cancellable
            );
        } catch (Error err) {
            if (err is IOError.CANCELLED) {
                throw (IOError.CANCELLED) err;
            }

            throw new RequestError.UNKNOWN ("Unknown error: %s", err.message);
        }

        var json = GJson.Node.parse ((string) response.get_data ());

        if (message.status_code >= 400) {
            throw RequestError.from_status_code (message.status_code, json);
        }

        return this.parse_response (json);
    }

    protected void add_path_param (string param) {
        this._path_params.add (param);
    }

    protected abstract TResponse parse_response (GJson.Node json);

    protected void set_query_param (string key, string value) {
        this._query_params[key] = value;
    }

    protected void unset_query_param (string key) {
        this._query_params.unset (key);
    }

    protected void update_path_param (string old_value, string new_value) {
        var index = this._path_params.index_of (old_value);

        if (index == -1) {
            critical ("Path param not found: %s", old_value);
            return;
        }

        this._path_params[index] = new_value;
    }

    private Uri build_uri () {
        var builder = new UriBuilder ("https") {
            host = this.host,
            path = this.base_path,
        };

        foreach (var param in this._path_params) {
            builder.append_path (param);
        }

        foreach (var param in this._query_params) {
            builder.append_query_param (param.key, param.value);
        }

        return builder.build ();
    }
}
