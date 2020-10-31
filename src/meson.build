replay_sources = files (
    'core/models/replay-core-video.vala',

    'pages/replay-home-page.vala',

    'widgets/replay-header-bar.vala',
    'widgets/replay-page.vala',
    'widgets/replay-stack-sidebar.vala',
    'widgets/replay-video-carousel-item.vala',

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
]


executable (
    meson.project_name (),
    replay_sources,

           dependencies: replay_dependencies,
                install: true,
                gui_app: true,
    include_directories: confinc
)
