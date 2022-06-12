/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public sealed class Iv.InvidiousApi {
    internal Soup.Session session { get; private set; }

    public InvidiousApi (Soup.Session? session = null) {
        this.session = session ?? new Soup.Session ();
    }

    public InstancesRequest instances () {
        return new InstancesRequest (this);
    }
}
