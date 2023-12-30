// Copyright 2019 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

[CCode (cheader_filename = "config.h", lower_case_cprefix = "")]
namespace Config {
    public const string APP_ID;
    public const string GETTEXT_PKG;
    public const string LOCALEDIR;
    public const string VERSION;
}
