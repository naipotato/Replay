sources = files (
	'Database/Models/Channel.vala',
	'Database/Models/Playlist.vala',
	'Database/Models/Video.vala',

	'Database/Dao.vala',

	'Enums/AdaptiveMode.vala',

	'Pages/TrendingPage.vala',
	'Pages/SearchPage.vala',
	'Pages/VideoPage.vala',

	'Utils/ObjectFactory.vala',
	'Utils/ObservableList.vala',

	'ViewModels/TrendingViewModel.vala',

	'Widgets/HeaderBar.vala',
	'Widgets/Page.vala',
	'Widgets/StackSidebar.vala',

	'Windows/ApplicationWindow.vala',
	'Windows/PreferencesWindow.vala',

	'Application.vala',
)


gnome = import ('gnome')

sources += gnome.compile_resources (
	'@0@.gresource'.format (meson.project_name ()),
	'@0@.gresource.xml'.format (meson.project_name ()),
	dependencies: custom_css
)


dependencies = [
	gtk_dep,
	gee_dep,
	config_dep,
	libhandy_dep,
	sqlite_dep,
	vadi_dep,
]


executable (
	meson.project_name (),
	sources,

	       dependencies: dependencies,
	            install: true,
	            gui_app: true,
	include_directories: confinc
)
