project (
    'unitube',
    'c', 'vala',
    version: '0.1.0',
    license: 'GPL-3.0-or-later'
)


add_project_arguments (
    '-DHANDY_USE_UNSTABLE_API',
    language: 'c'
)


application_id = 'com.gitlab.nahuelwexd.Unitube'
version = meson.project_version ()
package_url = 'https://gitlab.com/nahuelwexd/unitube'


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


subdir ('data')
subdir ('src')


meson.add_install_script ('build-aux/meson/postinstall.py')
