/*
 * Copyright 2019 Nahuel Gomez Castro <contact@nahuelgomez.com.ar>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[CCode (cheader_filename = "config.h", lower_case_cprefix = "")]
namespace Rpy.Constants {
	public const string APPLICATION_ID;
	public const string VERSION;
	public const string GETTEXT_PACKAGE;
	public const string LOCALEDIR;
}
