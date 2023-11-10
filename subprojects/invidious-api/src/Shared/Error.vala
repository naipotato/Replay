/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

public errordomain Iv.Error {
    BAD_REQUEST,
    CONFLICT,
    FORBIDDEN,
    INTERNAL_SERVER_ERROR,
    NOT_FOUND,
    REQUEST_TIMEOUT,
    SERVICE_UNAVAILABLE,
    UNAUTHORIZED,
    UNKNOWN;

    internal static Error from_status_code (Soup.Status status_code, GJson.Node json) {
        var server_error_message = "no server error message";

        if (json.node_type == OBJECT && json["error"].node_type == STRING)
            server_error_message = json["error"].as_string ();

        var reason_phrase = Soup.Status.get_phrase (status_code);
        var error_message = @"$reason_phrase: $server_error_message";

        switch (status_code) {
            case Soup.Status.BAD_REQUEST:
                return new Error.BAD_REQUEST (error_message);

            case Soup.Status.CONFLICT:
                return new Error.CONFLICT (error_message);

            case Soup.Status.FORBIDDEN:
                return new Error.FORBIDDEN (error_message);

            case Soup.Status.INTERNAL_SERVER_ERROR:
                return new Error.INTERNAL_SERVER_ERROR (error_message);

            case Soup.Status.NOT_FOUND:
                return new Error.NOT_FOUND (error_message);

            case Soup.Status.REQUEST_TIMEOUT:
                return new Error.REQUEST_TIMEOUT (error_message);

            case Soup.Status.SERVICE_UNAVAILABLE:
                return new Error.SERVICE_UNAVAILABLE (error_message);

            case Soup.Status.UNAUTHORIZED:
                return new Error.UNAUTHORIZED (error_message);

            default:
                return new Error.UNKNOWN (@"Unknown error: $server_error_message");
        }
    }
}
