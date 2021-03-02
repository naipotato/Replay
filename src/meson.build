replay_sources = files (
	'core/models/video.vala',

	'enums/view-category.vala',

	'pages/home-page.vala',
	'pages/page.vala',

	'services/navigation-service.vala',

	'utils/list-model.vala',
	'utils/observable-list.vala',

	'views/favorites-view.vala',
	'views/home-view.vala',
	'views/library-view.vala',
	'views/search-view.vala',
	'views/subscriptions-view.vala',
	'views/trends-view.vala',
	'views/view.vala',

	'widgets/header-bar.vala',
	'widgets/navigator.vala',
	'widgets/navigator-sidebar.vala',
	'widgets/video-carousel-item.vala',

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
