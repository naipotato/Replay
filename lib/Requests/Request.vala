/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public abstract class Iv.Request<TResponse> {
    private InvidiousApi _api_client;

    protected abstract string base_url { get; }
    protected abstract string method_name { get; }

    protected virtual Gee.List<string> path_params {
        get;
        default = Gee.List.empty ();
    }

    protected virtual Gee.Map<string, string> query_params {
        get;
        default = Gee.Map.empty ();
    }

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

    protected abstract TResponse parse_response (GJson.Node json);

    private Uri build_uri () {
        var builder = new UriBuilder ("https") {
            host = this.base_url,
            path = this.method_name,
        };

        foreach (var param in this.path_params) {
            builder.append_path (param);
        }

        foreach (var param in this.query_params) {
            builder.append_query_param (param.key, param.value);
        }

        return builder.build ();
    }
}
