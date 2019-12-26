sassc = find_program ('sassc')

custom_css = custom_target ('style.css',
               command: [sassc, '-M', '-t', 'compact', '@INPUT@', '@OUTPUT@'],
                 input: 'styles/style.scss',
                output: 'style.css',
    build_always_stale: true,
      build_by_default: true
)


gnome = import ('gnome')

resources = gnome.compile_resources (
    '@0@.gresource'.format (application_id),
    '@0@.gresource.xml'.format (application_id),
    dependencies: custom_css
)


install_data (
    '@0@.appearance.gschema.xml'.format (application_id),
    install_dir: get_option ('datadir') / 'glib-2.0' / 'schemas'
)

compile_schemas = find_program ('glib-compile-schemas', required: false)
if compile_schemas.found ()
    test (
        'Validate schema file',
        compile_schemas,
        args: ['--strict', '--dry-run', meson.current_source_dir ()]
    )
endif


desktop_file_conf = configuration_data ()
desktop_file_conf.set ('APP_ID', application_id)
desktop_file_conf.set ('EXECUTABLE', meson.project_name ())
desktop_file = configure_file (
            input: '@0@.desktop.in'.format (application_id),
           output: '@0@.desktop'.format (application_id),
    configuration: desktop_file_conf,
          install: true,
      install_dir: get_option ('datadir') / 'applications'
)

desktop_file_validate = find_program ('desktop-file-validate', required: false)
if desktop_file_validate.found ()
    test (
        'Validate desktop file',
        desktop_file_validate,
        args: desktop_file
    )
endif


install_data (
    'icons' / 'scalable' / 'apps' / '@0@.svg'.format (application_id),
    install_dir: get_option ('datadir') / 'icons' / 'hicolor' / 'scalable' / 'apps'
)

install_data (
    'icons' / 'symbolic' / 'apps' / '@0@-symbolic.svg'.format (application_id),
    install_dir: get_option ('datadir') / 'icons' / 'hicolor' / 'symbolic' / 'apps'
)
