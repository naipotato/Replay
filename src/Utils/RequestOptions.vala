/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

struct Rpy.RequestOptions {
    public string?                  method;
    public Gee.Map<string, string>? headers;
    public string?                  body;
}
