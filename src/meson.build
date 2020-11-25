replay_sources = files (
    'Core/Models/Video.vala',

    'Pages/HomePage.vala',

    'Widgets/HeaderBar.vala',
    'Widgets/StackSidebar.vala',
    'Widgets/VideoCarouselItem.vala',

    'Application.vala',
    'ApplicationWindow.vala',
    'Main.vala',
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
