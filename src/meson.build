# Get the source files
replay_sources = files (
  'services/settings-service.vala',
  'services/themes-service.vala',

  'utils/generic-list-model.vala',

  'view-models/trending-view-model.vala',

  'views/trending-view.vala',

  'widgets/error-message.vala',
  'widgets/main-header-bar.vala',
  'widgets/video-tile.vala',

  'app.vala',
  'app-window.vala',
  'constants.vala',
  'main.vala',
)


# Compile GResources in order to include into the source
gnome = import ('gnome')

resources = gnome.compile_resources (
  '@0@.gresource'.format (rdnn_app_name),
  '@0@.gresource.xml'.format (rdnn_app_name),
  dependencies: [custom_light_css, custom_dark_css]
)


# Get the compiler and the directory for vapi files
valac = meson.get_compiler ('vala')
vapidir = meson.source_root () / 'vapi'


# Get the dependencies
replay_deps = [
  glib_dep,
  gobject_dep,
  gee_dep,
  gio_dep,
  soup_dep,
  gtk_dep,
  config_dep,
  utlib_dep
]


# Build the project
executable (
  meson.project_name (),
  replay_sources, resources,

         dependencies: replay_deps,
              install: true,
  include_directories: confinc,
              gui_app: true
)
