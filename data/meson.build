# configure and install the desktop file in order to get an entry in the app drawer
configured_desktop_file = configure_file(
  format        : 'cmake',
  input         : f'@rdnn_app_name@.desktop.in.in',
  output        : f'@rdnn_app_name@.desktop.in',
  configuration : {
    'icon_name' : application_id,
    'command'   : meson.project_name(),
  },
)

desktop_file = i18n.merge_file(
  input       : configured_desktop_file,
  output      : f'@application_id@.desktop',
  po_dir      : meson.project_source_root() / 'po',
  type        : 'desktop',
  install     : true,
  install_dir : datadir / 'applications',
)

# verify if the desktop file is valid
desktop_file_validate = find_program('desktop-file-validate', required : false)

if desktop_file_validate.found()
  test(
    'validate-desktop-file',
    desktop_file_validate,

    args : desktop_file,
  )
endif

subdir('icons')
