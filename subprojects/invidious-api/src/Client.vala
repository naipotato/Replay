/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

public class Iv.Client {
    public string       instance { get; set; }
    public Soup.Session session  { get; private set; }

    public Client (string instance, Soup.Session? session = null) {
        this.instance = instance;
        this.session  = session ?? new Soup.Session ();
    }

    public TrendingRequest trending () {
        return new TrendingRequest (this);
    }

    public VideoRequest video (string id) {
        return new VideoRequest (this, id);
    }
}
