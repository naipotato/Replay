sources = [
  'App.vala',
  'AppWindow.vala',
]

resources = gnome.compile_resources('replay-resources', 'replay-resources.xml')

deps = [
  adwaita_dep,
  config_dep,
  gee_dep,
]

executable(
  application_id,
  sources, resources,

  dependencies  : deps,
  install       : true,
  win_subsystem : 'windows',
)
