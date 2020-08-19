#!/usr/bin/env -S sh -c "vala \"\$0\" --pkg posix --pkg gio-2.0 --run-args \"\$*\""

void write_constants_file (string data, string filename) {
  var file = File.new_for_commandline_arg (filename);

  try {
    // Create a new file or replace it if exists
    var ostream = file.replace (null, false, FileCreateFlags.NONE);

    // Write the data into the file
    var dostream = new DataOutputStream (ostream);
    dostream.put_string (@"$(data.strip ())\n");
  } catch (Error err) {
    printerr (@"Error: $(err.message)\n");
    Process.exit (Posix.EXIT_FAILURE);
  }
}

void main (string[] args) {
  // First, we need to check if the script is correctly used
  if (args.length != 3) {
    printerr (@"Usage: $(args[0]) API_KEY CONSTANTS_FILENAME\n");
    Process.exit (Posix.EXIT_FAILURE);
  }

  // Get the API key from the command line
  var api_key = args[1];

  // Get the filename from the command line
  var filename = args[2];

  // Create the template for the constants file
  var constants_file = """
  namespace Constants {

      [CCode (cname = "API_KEY")]
      public const string API_KEY = "%s";
  }
  """.printf (api_key);

  // Create the constants file
  write_constants_file (constants_file, filename);
}
