replay_sources = [
  'Views/View.vala',

  'App.vala',
  'AppWindow.vala',
]

replay_sources += icon_resources
replay_sources += gnome.compile_resources(
  'replay-ui-resources',
  'replay-ui-resources.xml',
)

replay_deps = [
  adwaita_dep,
  config_dep,
  gee_dep,
]

executable(
  meson.project_name(),
  replay_sources,

  dependencies  : replay_deps,
  install       : true,
  win_subsystem : 'windows',
)
