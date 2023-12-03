/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

public class Iv.FormatStream : Object {
    public string? container    { get; set; }
    public string? encoding     { get; set; }
    public string? itag         { get; set; }
    public string? quality      { get; set; }
    public string? qualityLabel { get; set; }
    public string? resolution   { get; set; }
    public string? size         { get; set; }
    [Description (nick = "json::type")]
    public string? fileType     { get; set; }
    public string? url          { get; set; }
}
