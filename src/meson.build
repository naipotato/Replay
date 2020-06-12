replay_sources = files (
    'dialogs' / 'about-dialog.vala',

    'services' / 'settings' / 'appearance-settings.vala',

    'services' / 'settings-service.vala',
    'services' / 'styling-service.vala',

    'utils' / 'generic-list-model.vala',

    'view-models' / 'trending-view-model.vala',
    'view-models' / 'view-model-locator.vala',

    'views' / 'library-view.vala',
    'views' / 'subscriptions-view.vala',
    'views' / 'trending-view.vala',

    'widgets' / 'main-header-bar.vala',

    'windows' / 'main-window.vala',
    'windows' / 'preferences-window.vala',

    'app.vala',
    'constants.vala',
)


valac = meson.get_compiler ('vala')
vapidir = meson.source_root () / 'vapi'


replay_deps = [
    glib_dep,
    gobject_dep,
    gee_dep,
    gio_dep,
    soup_dep,
    gtk_dep,
    handy_dep,
    config_dep,
    utlib_dep
]


executable (
    meson.project_name (),
    replay_sources, resources,

           dependencies: replay_deps,
                install: true,
    include_directories: confinc,
                gui_app: true
)
