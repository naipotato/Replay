/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace Rpy {
    async GJson.Node fetch (string resource, RequestOptions? options = null) throws Error {
        var session = new Soup.Session ();
        var method  = options?.method ?? "GET";

        var uri = Uri.parse (resource, Soup.HTTP_URI_FLAGS);

        var message = new Soup.Message.from_uri (method, uri);
        var headers = options?.headers ?? Gee.Map.empty<string, string> ();

        var request_headers = message.request_headers;
        foreach (var header in headers)
            request_headers.append (header.key, header.@value);

        if (options?.body != null)
            message.set_request_body_from_bytes (null, new Bytes (options.body.data));

        var bytes = yield session.send_and_read_async (message, Priority.DEFAULT, null);
        var json  = GJson.Node.parse ((string) Bytes.unref_to_data ((owned) bytes));

        if (message.status_code >= 400)
            throw HttpError.from_status_code (message.status_code, json);

        return json;
    }
}
