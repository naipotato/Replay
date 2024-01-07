// Copyright 2023 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

namespace Rpy.Utils {
    Dex.Future session_send_and_read (Soup.Session session, Soup.Message msg,
        int io_priority = Priority.DEFAULT_IDLE, Cancellable? cancellable = null)
    {
        var promise = new Dex.Promise ();

        session.send_and_read_async.begin (msg, io_priority, cancellable, (_, res) => {
            try {
                var bytes = session.send_and_read_async.end (res);
                promise.resolve (bytes);
            } catch (Error err) {
                promise.reject (err);
            }
        });

        return promise;
    }

    Dex.Future texture_from_bytes (Bytes bytes) {
        var scheduler = Dex.ThreadPoolScheduler.get_default ();
        return scheduler.spawn (0, () => {
            try {
                var texture = Gdk.Texture.from_bytes (bytes);
                return new Dex.Future.for_object (texture);
            } catch (Error err) {
                return new Dex.Future.for_error (err);
            }
        });
    }
}
