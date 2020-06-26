#!/usr/bin/env -S sh -c "vala \"\$0\" --pkg posix --pkg gio-2.0 --run-args \"\$*\""

const string constants_file =
"""
namespace Replay.Constants {

    [CCode (cname = "API_KEY")]
    public const string API_KEY = "%s";
}
""";

void write_constants_file (string data, string filename) {
    var file = File.new_for_commandline_arg (filename);

    try {
        // Create a new file or replace it if exists
        var ostream = file.replace (null, false, FileCreateFlags.NONE);
        var dostream = new DataOutputStream (ostream);
        dostream.put_string (@"$(data.strip ())\n");
    } catch (Error e) {
        stderr.printf (@"Error: $(e.message)\n");
        Process.exit (Posix.EXIT_FAILURE);
    }
}

void main (string[] args) {
    // First, we need to check if the script is correctly used
    if (args.length != 3) {
        stderr.printf (@"Usage: $(args[0]) API_KEY CONSTANTS_FILENAME\n");
        Process.exit (Posix.EXIT_FAILURE);
    }

    // Get the API key from the command line
    var api_key = args[1];

    // Get the filename from the command line
    var filename = args[2];

    // Create the constants file
    write_constants_file (constants_file.printf (api_key), filename);
}
