sources = [
  'Common/Errors/HttpError.vala',

  'Common/Utils/Fetch.vala',
  'Common/Utils/RequestOptions.vala',

  'Common/Widgets/Navigator.vala',

  'App.vala',
  'AppWindow.vala',
]

resources = gnome.compile_resources('replay-resources', 'replay-resources.xml')

valac   = meson.get_compiler('vala')
vapidir = meson.project_source_root() / 'vapi'

deps = [
  dependency('libadwaita-1', version : '>=1.2',  method : 'pkg-config'),
  dependency('gee-0.8',      version : '>=0.20', method : 'pkg-config'),
  dependency('gio-2.0',      version : '>=2.70', method : 'pkg-config'),
  dependency('gjson-1.0',    version : '>=1.0',  method : 'pkg-config'),
  dependency('libsoup-3.0',  version : '>=3.0',  method : 'pkg-config'),
  valac.find_library('config', dirs : vapidir),
]

executable(
  application_id,
  sources, resources,

  dependencies  : deps,
  install       : true,
  win_subsystem : 'windows',
)
