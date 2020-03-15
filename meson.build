project (
    'unitube',
    'c', 'vala',
    version: '0.1.0',
    license: 'GPL-3.0-or-later'
)


# Enable libhandy
add_project_arguments (
    '-DHANDY_USE_UNSTABLE_API',
    language: 'c'
)


# Info about the app
application_id = 'com.gitlab.nahuelwexd.Unitube'
package_url = 'https://gitlab.com/nahuelwexd/unitube'
version = run_command ('build-aux' / 'git_version.py', meson.project_version ()).stdout ().strip ()


# Generate a config include file with the info
config_h = configuration_data ()
config_h.set_quoted ('RESOURCE_PATH', '/com/gitlab/nahuelwexd/Unitube')
config_h.set_quoted ('APP_ID', application_id)
config_h.set_quoted ('VERSION', version)
config_h.set_quoted ('PACKAGE_URL', package_url)

configure_file (
    output: 'config.h',
    configuration: config_h
)

confinc = include_directories ('.')


# Subfolders
subdir ('data')
subdir ('src')


# Post install script
meson.add_install_script ('build-aux/post_install.py')
