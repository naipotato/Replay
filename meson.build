project ('replay', 'c', 'vala',
	version: '0.1.0',
	license: 'GPL-3.0-or-later'
)


# Enable gettext
i18n = import ('i18n')

add_project_arguments ('-DGETTEXT_PACKAGE=@0@'.format(meson.project_name ()),
	language: 'c'
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


# Info about the app
rdnn_app_name = 'com.github.nahuelwexd.Replay'
application_id = '@0@@1@'.format (rdnn_app_name, profile)
package_url = 'https://github.com/nahuelwexd/Replay'
resource_path = '/com/github/nahuelwexd/Replay'
version = '@0@-@VCS_TAG@'.format (meson.project_version ())
gettext_package = meson.project_name ()
localedir = get_option ('localedir')


# Generate a header with the info
config_h = configuration_data ()
config_h.set_quoted ('RDNN_APP_NAME', rdnn_app_name)
config_h.set_quoted ('APPLICATION_ID', application_id)
config_h.set_quoted ('PACKAGE_URL', package_url)
config_h.set_quoted ('RESOURCE_PATH', resource_path)
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
valac = meson.get_compiler ('vala')
vapidir = meson.source_root () / 'vapi'


# Dependencies
gtk_dep = dependency ('gtk4')
gee_dep = dependency ('gee-0.8')
xml_dep = dependency ('libxml-2.0')
gda_dep = dependency ('libgda-5.0')
config_dep = valac.find_library ('config', dirs: vapidir)


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
