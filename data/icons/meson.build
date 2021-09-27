# Install app icons
install_data ('scalable/apps/@0@.svg'.format (application_id),
	install_dir: datadir / 'icons/hicolor/scalable/apps'
)

install_data ('symbolic/apps/@0@-symbolic.svg'.format (meson.project_name ()),
	install_dir: datadir / 'icons/hicolor/symbolic/apps',
	     rename: '@0@-symbolic.svg'.format (application_id)
)


# Compile symbolic icons as resources
icon_resources = gnome.compile_resources (
	'replay-icon-resources',
	'replay-icon-resources.xml',
)
