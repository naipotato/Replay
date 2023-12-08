/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace Rpy.Utils {
    [CCode (has_target = false)]
    delegate bool SourceFunc<T> (T self);

    [CCode (has_target = false)]
    delegate void SourceOnceFunc<T> (T self);

    [CCode (has_target = false)]
    delegate bool TickCallback (Gtk.Widget widget, Gdk.FrameClock frame_clock);

    uint widget_add_tick_callback (Gtk.Widget self_, TickCallback func) {
        unowned var self = self_;
        return self.add_tick_callback ((widget, frame_clock) => func (widget, frame_clock));
    }

    uint timeout_add_seconds_once<T> (T self_, uint interval, SourceOnceFunc<T> func) {
        unowned var self = self_;

        return Timeout.add (interval * 1000, () => {
            func (self);
            return Source.REMOVE;
        }, Priority.DEFAULT_IDLE);
    }
}
