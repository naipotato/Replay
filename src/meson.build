vala_sources = files('App.vala', 'AppWindow.vala')
blp_sources  = files('AppWindow.blp')

subdir('Errors')
subdir('Features')
subdir('Models')
subdir('Repositories')
subdir('Utils')

resources = gnome.compile_resources('resources', 'resources.xml',
  c_name       : meson.project_name(),
  dependencies : custom_target(
    build_always_stale : true,
    command            : [
      find_program('blueprint-compiler'),
      'batch-compile',
      '@OUTPUT@',
      '@CURRENT_SOURCE_DIR@',
      '@INPUT@',
    ],
    input              : blp_sources,
    output             : '.',
  ),
)

vcs_tag(
  command  : ['git', 'rev-parse', '--short', 'HEAD'],
  fallback : profile,
  input    : configure_file(
    configuration : {
      'APP_ID'      : f'"@app_id@"',
      'GETTEXT_PKG' : f'"@gettext_pkg@"',
      'LOCALEDIR'   : f'"@localedir@"',
      'VERSION'     : f'"@version@"',
    },
    output        : 'config.h.in',
  ),
  output   : 'config.h',
)

executable(app_id,
  c_args              : [
    '-DG_LOG_DOMAIN="Replay"',
    '-DGETTEXT_PACKAGE=' + f'"@gettext_pkg@"',
  ],
  vala_args           : [
    '--define=' + profile.to_upper(),
    '--enable-checking',
    '--gresourcesdir=src/',
    '--nostdpkg',
  ],
  dependencies        : [
    dependency('gee-0.8',      method : 'pkg-config', version : '>=0.20'),
    dependency('gio-2.0',      method : 'pkg-config', version : '>=2.70'),
    dependency('gjson-1.0',    method : 'pkg-config', version : '>=1.0' ),
    dependency('glib-2.0',     method : 'pkg-config', version : '>=2.70'),
    dependency('gobject-2.0',  method : 'pkg-config', version : '>=2.70'),
    dependency('gtk4',         method : 'pkg-config', version : '>=4.12'),
    dependency('libadwaita-1', method : 'pkg-config', version : '>=1.4' ),
    dependency('libsoup-3.0',  method : 'pkg-config', version : '>=3.0' ),

    meson.get_compiler('vala').find_library('config', dirs : meson.project_source_root() / 'vapi'),
  ],
  include_directories : '.',
  install             : true,
  sources             : [resources, vala_sources],
  win_subsystem       : 'windows',
)
