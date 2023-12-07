/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.Video : Object {
    public Gee.Map<Quality, string>? qualities { get; set; }
    public string?                   title     { get; set; }

    public static Video from_api (Iv.Video api_video) {
        var qualities = new Gee.HashMap<Quality, string> ();

        foreach (var format_stream in api_video.formatStreams) {
            switch (format_stream.quality) {
                case "small":
                    qualities[Quality.SMALL] = format_stream.url;
                    break;

                case "medium":
                    qualities[Quality.MEDIUM] = format_stream.url;
                    break;

                case "hd720":
                    qualities[Quality.HD720] = format_stream.url;
                    break;
            }
        }

        return new Video () {
            qualities = qualities,
            title     = api_video.title,
        };
    }
}

enum Rpy.Quality {
    SMALL, MEDIUM, HD720;
}
