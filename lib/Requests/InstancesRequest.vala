/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public sealed class Iv.InstancesRequest : Request<Gee.List<Instance>> {
    private string[]? _sort_by;

    public string[]? sort_by {
        owned get { return this._sort_by; }
        set {
            this._sort_by = value;

            if (value == null) {
                this.unset_query_param ("sort_by");
                return;
            }

            this.set_query_param ("sort_by", string.joinv (",", value));
        }
    }

    protected override string host {
        get { return "api.invidious.io"; }
    }

    protected override string base_path {
        get { return "instances.json"; }
    }

    public InstancesRequest (InvidiousApi api_client) {
        base (api_client);
    }

    protected override Gee.List<Instance> parse_response (GJson.Node json) {
        var result = Gee.List.empty<Instance> ();

        try {
            var instances_json = json.as_array ().select ("$[*][1]");
            result = GJson.deserialize_array (instances_json);
        } catch (Error err) {
            warning ("Error parsing response: %s", err.message);
        }

        return result.read_only_view;
    }
}
