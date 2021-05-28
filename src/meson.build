replay_sources = files (
	'services/navigation-service.vala',

	'views/view.vala',

	'application.vala',
	'application-window.vala',
)


ui_resources = gnome.compile_resources (
	'replay-ui-resources',
	'replay-ui-resources.xml',
)


replay_dependencies = [
	gtk_dep,
	gee_dep,
	config_dep,
	adwaita_dep,
]


executable (
	meson.project_name (),
	replay_sources,
	icon_resources,
	ui_resources,

	       dependencies: replay_dependencies,
	            install: true,
	            gui_app: true,
	include_directories: confinc
)
