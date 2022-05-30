project ('app.drey.Replay', 'c', 'vala',
	        version: '0.1.0',
	        license: 'GPL-3.0-or-later',
	  meson_version: '>=0.56.0',
	default_options: ['warning_level=2']
)


add_project_arguments ('-DGETTEXT_PACKAGE=@0@'.format (meson.project_name ()),
	language: 'c'
)


# Add extra type checks in runtime
add_project_arguments ('--enable-checking',
	language: 'vala'
)


# Check the profile for this build
if get_option ('profile') == 'development'
	profile = '.Devel'

	add_project_arguments ('-D', 'DEVEL',
		language: 'vala'
	)
else
	profile = ''
endif

# Common dirs
prefix    = get_option ('prefix')
datadir   = prefix / get_option ('datadir')
localedir = prefix / get_option ('localedir')


# Info about the app
application_id  = '@0@@1@'.format (meson.project_name (), profile)
version         = '@0@-@VCS_TAG@'.format (meson.project_version ())
gettext_package = meson.project_name ()


# Generate a header with the info
config_h = configuration_data ()
config_h.set_quoted ('APPLICATION_ID', application_id)
config_h.set_quoted ('VERSION', version)
config_h.set_quoted ('GETTEXT_PACKAGE', gettext_package)
config_h.set_quoted ('LOCALEDIR', localedir)

config_h_in = configure_file (
	       output: 'config.h.in',
	configuration: config_h
)

vcs_tag (
	 command: ['git', 'rev-parse', '--short', 'HEAD'],
	fallback: get_option ('profile') != 'default' ? 'devel' : 'stable',
	   input: config_h_in,
	  output: 'config.h'
)

confinc = include_directories ('.')


# Common variables
valac   = meson.get_compiler ('vala')
vapidir = meson.project_source_root () / 'vapi'
gnome   = import ('gnome')
i18n    = import ('i18n')


# Dependencies
gtk_dep     = dependency ('gtk4', version: '>=4.4')
gee_dep     = dependency ('gee-0.8', version: '>=0.20')
adwaita_dep = dependency ('libadwaita-1', version: '>=1.0')
config_dep  = valac.find_library ('config', dirs: vapidir)


# Add vapidir for custom vapis
add_project_arguments ('--vapidir', vapidir,
	language: 'vala'
)


# Post install script
meson.add_install_script ('build-aux/meson/post-install.py')


# Subfolders
subdir ('data')
subdir ('src')
subdir ('po')


# Summary
summary ({
	'Prefix': get_option ('prefix'),
	'Profile': get_option ('profile'),
})
