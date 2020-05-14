sources = files (
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
)


valac = meson.get_compiler ('vala')
vapidir = meson.source_root () / 'vapi'


unitube_deps = [
    dependency ('gtk+-3.0', version: '>= 3.24'),
    dependency ('libhandy-1'),
    dependency ('gee-0.8'),
    dependency ('utlib-0.0'),
    valac.find_library ('config', dirs: vapidir)
]


executable (
    meson.project_name (),
    sources, resources,

           dependencies: unitube_deps,
                install: true,
    include_directories: confinc,
                gui_app: true
)
