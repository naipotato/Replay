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
}
