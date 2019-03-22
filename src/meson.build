sources = [
    'app.vala',
    'main-window.vala',
    'main.vala',

    resources
]

dependencies = [
    dependency ('gtk+-3.0')
]

executable (
    meson.project_name (),
    sources,
    dependencies: dependencies,
    gui_app: true,
    install: true
)
