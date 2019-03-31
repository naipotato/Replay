resources = gnome.compile_resources (
    '@0@.gresource'.format (app_id),
    '@0@.gresource.xml'.format (app_id)
)

desktop_conf = configuration_data ()
desktop_conf.set ('icon', app_id)
desktop_file = i18n.merge_file (
    'desktop-file',
    type: 'desktop',
    input: configure_file (
        input: files ('@0@.desktop.in.in'.format (app_id)),
        output: '@0@.desktop.in'.format (app_id),
        configuration: desktop_conf
    ),
    output: '@0@.desktop'.format (app_id),
    po_dir: podir,
    install: true,
    install_dir: join_paths (datadir, 'applications')
)

desktop_file_validate = find_program ('desktop-file-validate', required: false)
if desktop_file_validate.found ()
    test (
        'validate-desktop',
        desktop_file_validate,
        args: [
            desktop_file.full_path ()
        ]
    )
endif

install_data (
    '@0@.gschema.xml'.format (app_id),
    install_dir: join_paths (datadir, 'glib-2.0', 'schemas')
)

subdir ('icons')
