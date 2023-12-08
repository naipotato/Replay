vala_sources = files('Main.vala')
blp_sources  = files()

subdir('App')
subdir('Player')
subdir('Shared')
subdir('Trends')

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
    '--vapidir=' + meson.project_source_root() / 'vapi',
  ],
  dependencies        : [
    dependency('gee-0.8',       method : 'pkg-config', version : '>=0.20'),
    dependency('gio-2.0',       method : 'pkg-config', version : '>=2.70'),
    dependency('gjson-1.0',     method : 'pkg-config', version : '>=1.0' ),
    dependency('glib-2.0',      method : 'pkg-config', version : '>=2.70'),
    dependency('gobject-2.0',   method : 'pkg-config', version : '>=2.70'),
    dependency('gstreamer-1.0', method : 'pkg-config', version : '>=1.12'),
    dependency('gtk4',          method : 'pkg-config', version : '>=4.12'),
    dependency('icu-i18n',      method : 'pkg-config', version : '>=62.0'),
    dependency('libadwaita-1',  method : 'pkg-config', version : '>=1.4' ),
    dependency('libsoup-3.0',   method : 'pkg-config', version : '>=3.0' ),

    subproject('invidious-api').get_variable('invidious_api_dep'),

    meson.get_compiler('c').find_library('m'),
    meson.get_compiler('vala').find_library('config', dirs : meson.project_source_root() / 'vapi'),
  ],
  include_directories : '.',
  install             : true,
  sources             : [resources, vala_sources],
  win_subsystem       : 'windows',
)
