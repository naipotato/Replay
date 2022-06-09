/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public abstract class Iv.Request : Object {
    public virtual InvidiousApi? api_client { get; construct; }
    public abstract string base_url { get; }
    public abstract string method_name { get; }

    private Soup.Session? session {
        get { return this.api_client?.session; }
    }

    public virtual async GJson.Node? execute_async (
        Cancellable? cancellable = null
    ) throws RequestError, IOError requires (this.session != null) {
        var message = new Soup.Message (
            "GET",
            @"https://$(this.base_url)/$(this.method_name)?$(this.to_query ())"
        );

        Bytes response;

        try {
            response = yield this.session.send_and_read_async (
                message,
                Priority.DEFAULT,
                cancellable
            );
        } catch (Error err) {
            if (err is IOError.CANCELLED) {
                throw (IOError.CANCELLED) err;
            }

            throw new RequestError.UNKNOWN ("Unknown error: %s", err.message);
        }

        var json = GJson.Node.parse ((string) response.get_data ());

        if (message.status_code >= 400) {
            throw RequestError.from_status_code (message.status_code, json);
        }

        return json;
    }

    public virtual string to_query () {
        var klass = (ObjectClass) this.get_type ().class_ref ();
        var props = klass.list_properties ();

        var query = new UriQueryBuilder ();

        var props_to_ignore = new string[] {
            "api-client",
            "base-url",
            "method-name",
        };

        foreach (var prop in props) {
            if (prop.name in props_to_ignore) {
                continue;
            }

            var val = Value (prop.value_type);
            this.get_property (prop.name, ref val);

            query.append (prop.name, Functions.value_to_string (val));
        }

        return query.to_string ();
    }
}
