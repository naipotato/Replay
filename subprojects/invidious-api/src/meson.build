sources = files('client.vala')

subdir('shared')
subdir('trending')

deps = [
  dependency('gee-0.8',     method : 'pkg-config', version : '>=0.20'),
  dependency('gio-2.0',     method : 'pkg-config', version : '>=2.70'),
  dependency('gjson-1.0',   method : 'pkg-config', version : '>=1.0' ),
  dependency('libdex-1',    method : 'pkg-config', version : '>=0.4' ),
  dependency('libsoup-3.0', method : 'pkg-config', version : '>=3.0' ),
]

invidious_api = library(meson.project_name(),
  c_args       : ['-DG_LOG_DOMAIN="Invidious"'],
  vala_args    : [
    '--enable-checking',
    '--hide-internal',
    '--nostdpkg',
  ],
  dependencies : deps,
  install      : true,
  sources      : sources,
)

invidious_api_dep = declare_dependency(
  link_with           : invidious_api,
  dependencies        : deps,
  include_directories : '.',
)
