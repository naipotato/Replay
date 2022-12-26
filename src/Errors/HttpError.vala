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

        var error_object = json.as_object ();
        if (error_object.has_key ("error"))
            server_error_message = error_object["error"].as_string ();

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
