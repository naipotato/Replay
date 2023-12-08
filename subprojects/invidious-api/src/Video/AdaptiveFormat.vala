/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

public class Iv.AdaptiveFormat : Object {
    public string? index          { get; set; }
    public string? bitrate        { get; set; }
    public string? init           { get; set; }
    public string? itag           { get; set; }
    [Description (nick = "json::type")]
    public string? fileType       { get; set; }
    public string? clen           { get; set; }
    public string? lmt            { get; set; }
    public string? projectionType { get; set; }
    public string? container      { get; set; }
    public string? encoding       { get; set; }
    public string? qualityLabel   { get; set; }
    public string? resolution     { get; set; }
}
