/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

errordomain Rpy.HttpError {
    BAD_REQUEST,
    CONFLICT,
    FORBIDDEN,
    INTERNAL_SERVER_ERROR,
    NOT_FOUND,
    REQUEST_TIMEOUT,
    SERVICE_UNAVAILABLE,
    UNAUTHORIZED,
    UNKNOWN;

    public static HttpError from_status_code (Soup.Status status_code, GJson.Node json) {
        var server_error_message = "no server error message";

        if (json.node_type == OBJECT && json["error"].node_type == STRING)
            server_error_message = json["error"].as_string ();

        var reason_phrase = Soup.Status.get_phrase (status_code);
        var error_message = @"$reason_phrase: $server_error_message";

        switch (status_code) {
            case Soup.Status.BAD_REQUEST:
                return new HttpError.BAD_REQUEST (error_message);

            case Soup.Status.CONFLICT:
                return new HttpError.CONFLICT (error_message);

            case Soup.Status.FORBIDDEN:
                return new HttpError.FORBIDDEN (error_message);

            case Soup.Status.INTERNAL_SERVER_ERROR:
                return new HttpError.INTERNAL_SERVER_ERROR (error_message);

            case Soup.Status.NOT_FOUND:
                return new HttpError.NOT_FOUND (error_message);

            case Soup.Status.REQUEST_TIMEOUT:
                return new HttpError.REQUEST_TIMEOUT (error_message);

            case Soup.Status.SERVICE_UNAVAILABLE:
                return new HttpError.SERVICE_UNAVAILABLE (error_message);

            case Soup.Status.UNAUTHORIZED:
                return new HttpError.UNAUTHORIZED (error_message);

            default:
                return new HttpError.UNKNOWN (@"Unknown error: $server_error_message");
        }
    }
}
