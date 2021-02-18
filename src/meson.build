replay_sources = files (
	'core/models/video.vala',

	'pages/home-page.vala',

	'widgets/header-bar.vala',
	'widgets/stack-sidebar.vala',
	'widgets/video-carousel-item.vala',

	'application.vala',
	'application-window.vala',
)


ui_resources = gnome.compile_resources (
	'replay-ui-resources',
	'replay-ui-resources.xml',
	dependencies: custom_css
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
