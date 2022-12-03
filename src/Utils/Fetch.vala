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
            throw error_by_status_code (message.status_code, json);

        return json;
    }

    HttpError error_by_status_code (Soup.Status status_code, GJson.Node json) {
        var server_error_message = "no server error message";

        var error_object = json.as_object ();
        if (error_object.has_key ("error"))
            server_error_message = error_object.get_string_member ("error");

        switch (status_code) {
            case BAD_REQUEST:
                return new HttpError.BAD_REQUEST ("%s: %s",
                    Soup.Status.get_phrase (status_code), server_error_message);

            case UNAUTHORIZED:
                return new HttpError.UNAUTHORIZED ("%s: %s",
                    Soup.Status.get_phrase (status_code), server_error_message);

            case FORBIDDEN:
                return new HttpError.FORBIDDEN ("%s: %s",
                    Soup.Status.get_phrase (status_code), server_error_message);

            case NOT_FOUND:
                return new HttpError.NOT_FOUND ("%s: %s",
                    Soup.Status.get_phrase (status_code), server_error_message);

            case REQUEST_TIMEOUT:
                return new HttpError.REQUEST_TIMEOUT ("%s: %s",
                    Soup.Status.get_phrase (status_code), server_error_message);

            case CONFLICT:
                return new HttpError.CONFLICT ("%s: %s",
                    Soup.Status.get_phrase (status_code), server_error_message);

            case INTERNAL_SERVER_ERROR:
                return new HttpError.INTERNAL_SERVER_ERROR ("%s: %s",
                    Soup.Status.get_phrase (status_code), server_error_message);

            case SERVICE_UNAVAILABLE:
                return new HttpError.SERVICE_UNAVAILABLE ("%s: %s",
                    Soup.Status.get_phrase (status_code), server_error_message);

            default:
                return new HttpError.UNKNOWN ("Unknown error: %s",
                    server_error_message);
        }
    }
}
