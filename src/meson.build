sources = [
    'core/requests/request.vala',
    'core/requests/video-list-request.vala',

    'core/resources/resource.vala',
    'core/resources/thumbnail.vala',
    'core/resources/video.vala',

    'core/responses/video-list-response.vala',

    'core/api-error.vala',

    'dialogs/about-dialog.vala',

    'services/settings-service.vala',

    'widgets/header-bar.vala',
    'widgets/search-bar.vala',

    'app.vala',
    'main-window.vala',
    'main.vala',

    resources
]

dependencies = [
    glib_dep,
    gobject_dep,
    gtk_dep,
    gee_dep,
    soup_dep,
    handy_dep,
    gjson_dep
]

executable (
    meson.project_name (),
    sources,
    dependencies: dependencies,
    gui_app: true,
    install: true
)
