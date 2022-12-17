/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.Video : Object {
    public string   id               { get; set; }
    public Uri      thumbnail_uri    { get; set; }
    public string   title            { get; set; }
    public string   author           { get; set; }
    public int64    view_count       { get; set; }
    public DateTime publication_date { get; set; }
    public TimeSpan duration         { get; set; }
}
