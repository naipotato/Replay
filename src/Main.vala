/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

int main (string[] args) {
    Gst.init (ref args);

    // See https://docs.gtk.org/glib/i18n.html
    Intl.bindtextdomain (Config.GETTEXT_PKG, Config.LOCALEDIR);
    Intl.bind_textdomain_codeset (Config.GETTEXT_PKG, "UTF-8");
    Intl.textdomain (Config.GETTEXT_PKG);

    return new Rpy.App ().run (args);
}
