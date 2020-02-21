sources = files (
    'dialogs/about-dialog.vala',

    'enums/app-theme.vala',
    'enums/element-theme.vala',

    'services/settings/appearance-settings.vala',

    'services/settings-service.vala',

    'view-models/trending-view-model.vala',

    'views/library-view.vala',
    'views/subscriptions-view.vala',
    'views/trending-view.vala',

    'widgets/main-header-bar.vala',

    'windows/main-window.vala',
    'windows/preferences-window.vala',

    'app.vala',
)

valac = meson.get_compiler ('vala')
vapidir = meson.source_root () / 'vapi'

executable (
    meson.project_name (),
    sources, resources,
    dependencies: [
        dependency ('gtk+-3.0', version: '>= 3.24'),
        dependency ('libhandy-0.0', version: '>= 0.0.10'),
        dependency ('gee-0.8'),
        valac.find_library ('config', dirs: vapidir)
    ],
    install: true,
    include_directories: confinc
)
