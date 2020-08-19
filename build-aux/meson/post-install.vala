#!/usr/bin/env vala

void call (string[] call_args) {
  try {
    string call_stdout;
    string call_stderr;
    int call_status;

    Process.spawn_command_line_sync (string.joinv (" ", call_args), out call_stdout, out call_stderr,
      out call_status);

    if (call_status != 0) {
      Process.exit (call_status);
    }
  } catch (Error e) {
    Process.exit (1);
  }
}

var prefix = Environment.get_variable ("MESON_INSTALL_PREFIX") ?? "/usr/local";
var datadir = Path.build_filename (prefix, "share");
var destdir = Environment.get_variable ("DESTDIR");

if (destdir == null) {
  print ("Updating icon cache...\n");
  call ({"gtk-update-icon-cache", "-qtf", Path.build_filename (datadir, "icons", "hicolor")});

  print ("Compiling GSettings schemas...\n");
  call ({"glib-compile-schemas", Path.build_filename (datadir, "glib-2.0", "schemas")});
}
