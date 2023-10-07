desktop_file = i18n.merge_file(
  input       : configure_file(
    configuration : {
      'command'   : app_id,
      'icon_name' : app_id,
    },
    input         : f'@reverse_dns@.desktop.in.in',
    output        : f'@reverse_dns@.desktop.in',
  ),
  install     : true,
  install_dir : datadir / 'applications',
  output      : f'@app_id@.desktop',
  po_dir      : meson.project_source_root() / 'po',
  type        : 'desktop',
)

desktop_file_validate = find_program('desktop-file-validate', required : false)

if desktop_file_validate.found()
  test('validate-desktop-file', desktop_file_validate, args : desktop_file)
endif

subdir('icons')
