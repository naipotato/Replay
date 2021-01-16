replay_sources = files (
	'Enums/ViewCategory.vala',

	'Pages/Page.vala',

	'Services/NavigationService.vala',

	'Views/View.vala',

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
