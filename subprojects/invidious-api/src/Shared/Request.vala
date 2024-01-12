// Copyright 2023 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: LGPL-3.0-or-later

public abstract class Iv.Request<TResponse> {
    private Gee.Map<string, string> _query_params = new Gee.HashMap<string, string> ();

    internal virtual string method {
        get { return "GET"; }
    }

    internal abstract string host { get; }
    internal abstract string path { get; }

    internal virtual Soup.Session session () {
        return new Soup.Session ();
    }

    internal void add_query_param (string key, string @value) {
        this._query_params[key] = @value;
    }

    internal void remove_query_param (string key) {
		this._query_params.unset (key);
	}

	internal virtual Gee.Map<string, string> headers () {
		return Gee.Map.empty ();
	}

	internal virtual string? body () {
		return null;
	}

    public async TResponse execute_async () throws Error {
        Soup.Session session = this.session ();

        var message = new Soup.Message.from_uri (this.method, this.build_uri ());

        Soup.MessageHeaders request_headers = message.get_request_headers ();
        foreach (var header in this.headers ()) {
            request_headers.append (header.key, header.@value);
        }

        string? body = this.body ();
        if (body != null) {
            message.set_request_body_from_bytes (null, new Bytes (body.data));
        }

        Bytes bytes;

        try {
            bytes = yield session.send_and_read_async (message, Priority.DEFAULT_IDLE, null);
        } catch (GLib.Error err) {
            throw new Error.UNKNOWN (@"Unknown error: $(err.message)");
        }

        uint8[] data = Bytes.unref_to_data ((owned) bytes);

        var raw_text = (string) data;
        int raw_text_length = data.length;

        GJson.Node node = GJson.Node.parse (raw_text.make_valid (raw_text_length));

        if (message.status_code >= 400) {
            throw Error.from_status_code (message.status_code, node);
        }

        return this.parse_response (node);
    }

    private Uri build_uri () {
        var builder = new Utils.UriBuilder ("https") {
            host = this.host,
            path = this.path,
        };

        foreach (Gee.Map.Entry<string, string>? param in this._query_params) {
            if (param != null) {
                builder.add_query_param (param.key, param.@value);
            }
        }

        return builder.build ();
    }

    internal abstract TResponse parse_response (GJson.Node json);
}
