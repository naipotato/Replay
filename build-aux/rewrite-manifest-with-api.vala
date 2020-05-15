#!/usr/bin/env -S sh -c "vala \"\$0\" --pkg json-glib-1.0 --pkg gio-2.0 --run-args \"\$*\""

string get_manifest (string path) {
    // Get a new file from the path
    var file = File.new_for_commandline_arg (path);

    // If the file does not exists, throw an error
    if (!file.query_exists ()) {
        error (@"File $path doesn't exist.\n");
    }

    try {
        // Open the file for reading
        var istream = file.read ();
        var distream = new DataInputStream (istream);

        var builder = new StringBuilder ();

        // Read it
        string line;
        while ((line = distream.read_line ()) != null) {
            builder.append (@"$line\n");
        }

        return builder.str;
    } catch (Error e) {
        // If something has failed, throw an error
        error (e.message);
    }
}

Json.Array get_config_opts (Json.Node data, string module_name) {
    // Get the modules array
    var modules = data.get_object ().get_array_member ("modules");

    for (int i = 0; i < modules.get_length (); i++) {
        var module = modules.get_object_element (i);

        // If the module is not the specified, skip it
        if (module.get_string_member ("name") != module_name) {
            continue;
        }

        return module.get_array_member ("config-opts");
    }

    return null;
}

void write_manifest (string data, string path) {
    // Open the specified file
    var file = File.new_for_commandline_arg (path);

    try {
        // And try to replace it with the new content. If the file doesn't exists
        // for some reason, it will be created again
        var ostream = file.replace (null, false, FileCreateFlags.NONE);
        var dostream = new DataOutputStream (ostream);
        dostream.put_string (@"$data\n");
    } catch (Error e) {
        error (e.message);
    }
}

void main (string[] args) {
    // Get manifest path and module name
    var (manifest_path, module_name) = args[1:3];

    // If manifest_path or module_name are null, throw an error
    if (manifest_path == null || module_name == null) {
        stderr.printf (@"usage: $(args[0]) flatpak_manifest module_name\n");
        Process.exit (1);
    }

    // Get manifest from path
    var manifest = get_manifest (manifest_path);

    // Get the config_opts from the JSON
    var json = Json.from_string (manifest);
    var config_opts = get_config_opts (json, module_name);

    // Get the API_KEY env var, and add it as a config option
    var api_key = Environment.get_variable ("API_KEY");
    if (api_key == null) {
        error (@"API_KEY env var is not set");
    }

    config_opts.add_string_element (@"-Dapi-key=$api_key");

    // Write the JSON into the file
    write_manifest (Json.to_string (json, true), manifest_path);
}
