/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public errordomain Iv.RequestError {
    BAD_REQUEST,
    CONFLICT,
    FORBIDDEN,
    INTERNAL_SERVER_ERROR,
    NOT_FOUND,
    REQUEST_TIMEOUT,
    SERVICE_UNAVAILABLE,
    UNAUTHORIZED,
    UNKNOWN;

    public static RequestError from_status_code (Soup.Status status_code, GJson.Node json) {
        var server_error_message = "no server error message";

        if (json.node_type == OBJECT) {
            var error_object = json.as_object ();

            if (error_object.has_key ("error")) {
                server_error_message = error_object.get_string_member ("error");
            }
        }

        var reason_phrase = Soup.Status.get_phrase (status_code);

        switch (status_code) {
            case Soup.Status.BAD_REQUEST:
                return new RequestError.BAD_REQUEST (@"$reason_phrase: $server_error_message");

            case Soup.Status.CONFLICT:
                return new RequestError.CONFLICT (@"$reason_phrase: $server_error_message");

            case Soup.Status.FORBIDDEN:
                return new RequestError.FORBIDDEN (@"$reason_phrase: $server_error_message");

            case Soup.Status.INTERNAL_SERVER_ERROR:
                return new RequestError.INTERNAL_SERVER_ERROR (@"$reason_phrase: $server_error_message");

            case Soup.Status.NOT_FOUND:
                return new RequestError.NOT_FOUND (@"$reason_phrase: $server_error_message");

            case Soup.Status.REQUEST_TIMEOUT:
                return new RequestError.REQUEST_TIMEOUT (@"$reason_phrase: $server_error_message");

            case Soup.Status.SERVICE_UNAVAILABLE:
                return new RequestError.SERVICE_UNAVAILABLE (@"$reason_phrase: $server_error_message");

            case Soup.Status.UNAUTHORIZED:
                return new RequestError.UNAUTHORIZED (@"$reason_phrase: $server_error_message");

            default:
                return new RequestError.UNKNOWN (@"Unknown error: $server_error_message");
        }
    }
}
