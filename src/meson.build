sources = [
    'core/requests/request.vala',
    'core/requests/video-list-request.vala',

    'core/resources/resource.vala',
    'core/resources/thumbnail.vala',
    'core/resources/video.vala',

    'core/responses/video-list-response.vala',

    'core/api-error.vala',

    'dialogs/about-dialog.vala',

    'widgets/header-bar.vala',

    'app.vala',
    'main-window.vala',
    'main.vala',

    resources
]

dependencies = [
    dependency ('glib-2.0'),
    dependency ('gobject-2.0'),
    dependency ('gtk+-3.0'),
    dependency ('gee-0.8'),
    dependency ('libsoup-2.4'),
    vul_proj.get_variable ('gjson_dep')
]

executable (
    meson.project_name (),
    sources,
    dependencies: dependencies,
    gui_app: true,
    install: true
)
