project ('unitube', 'c', 'vala',
    version: '0.1.0',
    license: 'GPL-3.0-or-later'
)


# Enable libhandy
add_project_arguments ('-DHANDY_USE_UNSTABLE_API',
    language: 'c'
)


# Check the profile for this build
if get_option ('profile') == 'development'
    name_suffix = ' (Development)'
    profile = '.Devel'
else
    name_suffix = ''
    profile = ''
endif


# Info about the app
rdnn_app_name = 'com.github.nahuelwexd.UniTube'
application_name = 'Unitube@0@'.format (name_suffix)
application_id = '@0@@1@'.format (rdnn_app_name, profile)
package_url = 'https://github.com/nahuelwexd/UniTube-GTK'
resource_path = '/com/github/nahuelwexd/UniTube'
version = run_command ('build-aux' / 'git_version.py', meson.project_version ()).stdout ().strip ()


# Generate a config include file with the info
config_h = configuration_data ()
config_h.set_quoted ('RDNN_APP_NAME', rdnn_app_name)
config_h.set_quoted ('APPLICATION_NAME', application_name)
config_h.set_quoted ('APPLICATION_ID', application_id)
config_h.set_quoted ('PACKAGE_URL', package_url)
config_h.set_quoted ('RESOURCE_PATH', resource_path)
config_h.set_quoted ('VERSION', version)

configure_file (
           output: 'config.h',
    configuration: config_h
)

confinc = include_directories ('.')


# Post install script
meson.add_install_script ('build-aux/post_install.py')


# Subfolders
subdir ('data')
subdir ('src')
