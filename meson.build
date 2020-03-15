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
package_url = 'https://gitlab.com/nahuelwexd/unitube'

git = find_program ('git', required: false)

if git.found ()
    result = run_command ('git', 'describe', '--tags', '|', 'sed', '\'s/-/.r/; s/-/./\'')
    if result.returncode () != 0
        result = run_command ('git', 'rev-list', '--count', 'HEAD')
        if result.returncode () == 0
            rev_count = result.stdout ().strip ()

            result = run_command ('git', 'rev-parse', '--short', 'HEAD')
            rev = result.stdout ().strip ()

            version = 'r@0@.@1@'.format (rev_count, rev)
        else
            version = meson.project_version ()
        endif
    else
        version = result.stdout ().strip ()
    endif
else
    version = meson.project_version ()
endif


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

meson.add_install_script ('build-aux/post_install.py')
