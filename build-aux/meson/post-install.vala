#!/usr/bin/env vala

void call (string[] call_args)
{
	string call_stdout;
	string call_stderr;
	int	   call_status;

	try {
		Process.spawn_command_line_sync (
			string.joinv (" ", call_args),
			out call_stdout,
			out call_stderr,
			out call_status
		);

		Process.check_exit_status (call_status);
	} catch (Error err) {
		error ("An error ocurred calling '%s': %s", string.joinv (" ", call_args), err.message);
	}
}

void main ()
{
	string	prefix	= Environment.get_variable ("MESON_INSTALL_PREFIX") ?? "/usr/local";
	string	datadir	= Path.build_filename (prefix, "share");
	string? destdir = Environment.get_variable ("DESTDIR");

	if (destdir == null) {
		print ("Updating icon cache...\n");
		call ({ "gtk-update-icon-cache", "-qtf", Path.build_filename (datadir, "icons", "hicolor") });
	}
}
