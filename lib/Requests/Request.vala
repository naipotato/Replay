/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public abstract class Iv.Request<TResponse> {
    private InvidiousApi _api_client;

    private Gee.Map<string, string> _path_segments =
        new Gee.HashMap<string, string> ();

    private Gee.Map<string, string> _parameters =
        new Gee.HashMap<string, string> ();

    protected abstract string host { get; }
    protected abstract string path { get; }

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

    protected void append_parameter (string key, string value) {
        this._parameters[key] = value;
    }

    protected abstract TResponse parse_response (GJson.Node json);

    protected void remove_parameter (string key) {
        this._parameters.unset (key);
    }

    protected void set_path_segment (string key, string value) {
        this._path_segments[key] = value;
    }

    private Uri build_uri () {
        var builder = new UriBuilder ("https") {
            host = this.host,
            path = this.path,
        };

        foreach (var segment in this._path_segments) {
            builder.set_path_segment (segment.key, segment.value);
        }

        foreach (var parameter in this._parameters) {
            builder.append_parameter (parameter.key, parameter.value);
        }

        return builder.build ();
    }
}
