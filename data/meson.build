# Compile SASS into CSS for custom styles
sassc = find_program ('sassc')

custom_light_css = custom_target ('styles.css',
               command: [sassc, '-M', '-t', 'compact', '@INPUT@', '@OUTPUT@'],
                 input: 'styles' / 'styles.scss',
                output: 'styles.css',
    build_always_stale: true,
      build_by_default: true
)

custom_dark_css = custom_target ('styles-dark.css',
               command: [sassc, '-M', '-t', 'compact', '@INPUT@', '@OUTPUT@'],
                 input: 'styles' / 'styles-dark.scss',
                output: 'styles-dark.css',
    build_always_stale: true,
      build_by_default: true
)

# Compile GResources in order to include into the source
gnome = import ('gnome')

resources = gnome.compile_resources (
    '@0@.gresource'.format (rdnn_app_name),
    '@0@.gresource.xml'.format (rdnn_app_name),
    dependencies: [custom_light_css, custom_dark_css]
)


# Install GSchemas in order to get available the GSettings
install_data (
    '@0@.gschema.xml'.format (rdnn_app_name),
    install_dir: get_option ('datadir') / 'glib-2.0' / 'schemas'
)


# Verify if the GSchemas file is valid
compile_schemas = find_program ('glib-compile-schemas', required: false)

if compile_schemas.found ()
    test (
        'Validate schema file',
        compile_schemas,
        args: ['--strict', '--dry-run', meson.current_source_dir ()]
    )
endif


# Install Appstream file in order to provide metadata for this app
install_data (
    '@0@.metainfo.xml'.format (rdnn_app_name),
    install_dir: get_option ('datadir') / 'metainfo'
)


# Verify if the Appstream file is valid
appstream_util = find_program ('appstream-util', required: false)

if appstream_util.found ()
    test (
        'Validate appstream file',
        appstream_util,
        args: ['validate', files ('@0@.metainfo.xml'.format (rdnn_app_name))],
        should_fail: true # Since I've no releases tag, this should fail.
    )
endif


# Configure and install the desktop file in order to get an entry in the app
# drawer
desktop_file_conf = configuration_data ()
desktop_file_conf.set ('APPLICATION_NAME', application_name)
desktop_file_conf.set ('APPLICATION_ID', application_id)
desktop_file_conf.set ('EXECUTABLE', meson.project_name ())
desktop_file = configure_file (
            input: '@0@.desktop.in'.format (rdnn_app_name),
           output: '@0@.desktop'.format (application_id),
    configuration: desktop_file_conf,
          install: true,
      install_dir: get_option ('datadir') / 'applications'
)


# Verify if the desktop file is valid
desktop_file_validate = find_program ('desktop-file-validate', required: false)

if desktop_file_validate.found ()
    test (
        'Validate desktop file',
        desktop_file_validate,
        args: desktop_file
    )
endif


# Install icons
install_data (
    'icons' / 'scalable' / 'apps' / '@0@.svg'.format (application_id),
    install_dir: get_option ('datadir') / 'icons' / 'hicolor' / 'scalable' / 'apps'
)

install_data (
    'icons' / 'symbolic' / 'apps' / '@0@-symbolic.svg'.format (rdnn_app_name),
    install_dir: get_option ('datadir') / 'icons' / 'hicolor' / 'symbolic' / 'apps',
    rename: '@0@-symbolic.svg'.format (application_id)
)
