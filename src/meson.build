sources = [
  'Common/Errors/HttpError.vala',

  'Common/Utils/Fetch.vala',
  'Common/Utils/RequestOptions.vala',

  'Common/Widgets/Navigator.vala',

  'App.vala',
  'AppWindow.vala',
]

resources = gnome.compile_resources('replay-resources', 'replay-resources.xml')

deps = [
  adwaita_dep,
  config_dep,
  gee_dep,
  gjson_dep,
  soup_dep,
]

executable(
  application_id,
  sources, resources,

  dependencies  : deps,
  install       : true,
  win_subsystem : 'windows',
)
