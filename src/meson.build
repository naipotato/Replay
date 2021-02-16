replay_sources = files (
	'core/models/video.vala',

	'pages/home-page.vala',

	'widgets/header-bar.vala',
	'widgets/stack-sidebar.vala',
	'widgets/video-carousel-item.vala',

	'application.vala',
	'application-window.vala',
)


gnome = import ('gnome')

replay_sources += gnome.compile_resources (
	'@0@.gresource'.format (meson.project_name ()),
	'@0@.gresource.xml'.format (meson.project_name ()),
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

	       dependencies: replay_dependencies,
	            install: true,
	            gui_app: true,
	include_directories: confinc
)
