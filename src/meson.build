replay_sources = files (
	'Enums/PageKey.vala',
	'Enums/ViewCategory.vala',

	'Pages/MainPage.vala',
	'Pages/Page.vala',

	'Services/NavigationService.vala',

	'Utils/ListModel.vala',
	'Utils/ObservableList.vala',

	'Views/FavoritesView.vala',
	'Views/HomeView.vala',
	'Views/LibraryView.vala',
	'Views/SearchView.vala',
	'Views/SubscriptionsView.vala',
	'Views/TrendsView.vala',
	'Views/View.vala',

	'Widgets/MainHeaderBar.vala',
	'Widgets/ViewList.vala',

	'Application.vala',
	'ApplicationWindow.vala',
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
	libhandy_dep,
]


executable (
	meson.project_name (),
	replay_sources,

	       dependencies: replay_dependencies,
	            install: true,
	            gui_app: true,
	include_directories: confinc
)
