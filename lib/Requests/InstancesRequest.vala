/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public sealed class Iv.InstancesRequest : Request<Gee.List<Instance>> {
    private string[]? _sort_by;

    public string[]? sort_by {
        owned get {

            /*
             * This is owned so that the returned array is always a copy and
             * not the original array, so that to make alterations on it you
             * must always go through the setter
             */

            return this._sort_by;
        }
        set {
            this._sort_by = value;

            if (value == null) {
                this.remove_parameter ("sort_by");
                return;
            }

            this.append_parameter ("sort_by", string.joinv (",", value));
        }
    }

    protected override string host {
        get { return "api.invidious.io"; }
    }

    protected override string path {
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
            warning (@"Error parsing response: $(err.message)");
        }

        return result.read_only_view;
    }
}
