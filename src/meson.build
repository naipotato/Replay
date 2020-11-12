replay_sources = files (
    'helpers/replay-helpers-adaptiveness-manager.vala',
    'helpers/replay-helpers-container.vala',

    'pages/replay-home-page.vala',
    'pages/replay-search-page.vala',

    'widgets/replay-header-bar.vala',
    'widgets/replay-page.vala',
    'widgets/replay-stack-sidebar.vala',

    'replay-app.vala',
    'replay-app-window.vala',
    'replay-main.vala',
)


gnome = import ('gnome')

replay_sources += gnome.compile_resources (
    'replay-resources',
    '@0@.gresource.xml'.format (meson.project_name ()),
    dependencies: custom_css
)


replay_dependencies = [
    gtk_dep,
    gee_dep,
    config_dep,
    libhandy_dep,
    sqlite_dep,
    vadi_dep,
]


executable (
    meson.project_name (),
    replay_sources,

           dependencies: replay_dependencies,
                install: true,
                gui_app: true,
    include_directories: confinc
)
