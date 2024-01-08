// Copyright 2023 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: LGPL-3.0-or-later

namespace Iv.Utils {
    Dex.Future session_send_and_read (Soup.Session session, Soup.Message msg,
        int io_priority = Priority.DEFAULT_IDLE, Cancellable? cancellable = null)
    {
        var promise = new Dex.Promise ();

        session.send_and_read_async.begin (msg, io_priority, cancellable, (_, res) => {
            try {
                var bytes = session.send_and_read_async.end (res);
                promise.resolve (bytes);
            } catch (GLib.Error err) {
                promise.reject (err);
            }
        });

        return promise;
    }
}
