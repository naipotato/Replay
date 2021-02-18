# Compile SASS into CSS for custom styles
sassc = find_program ('sassc')

custom_css = custom_target ('custom-css',
	           command: [sassc, '-M', '-t', 'compact', '@INPUT@', '@OUTPUT@'],
	             input: 'styles/styles.scss',
	            output: 'styles.css',
	build_always_stale: true,
	  build_by_default: true
)


# Configure and install the desktop file in order to get an entry in the app drawer
desktop_file_conf = configuration_data ()
desktop_file_conf.set ('APPLICATION_ID', application_id)
desktop_file_conf.set ('EXECUTABLE', meson.project_name ())

configured_desktop_file = configure_file (
	        input: '@0@.desktop.in.in'.format (meson.project_name ()),
	       output: '@0@.desktop.in'.format (meson.project_name ()),
	configuration: desktop_file_conf
)

desktop_file = i18n.merge_file (
	      input: configured_desktop_file,
	     output: '@0@.desktop'.format (application_id),
	     po_dir: meson.source_root () / 'po',
	       type: 'desktop',
	    install: true,
	install_dir: get_option ('datadir') / 'applications'
)


# Verify if the desktop file is valid
desktop_file_validate = find_program ('desktop-file-validate', required: false)

if desktop_file_validate.found ()
	test (
		'validate-desktop-file',
		desktop_file_validate,
		args: desktop_file
	)
endif

# Install app icons
install_data ('icons/scalable/apps/@0@.svg'.format (application_id),
	install_dir: get_option ('datadir') / 'icons/hicolor/scalable/apps'
)

install_data ('icons/symbolic/apps/@0@-symbolic.svg'.format (meson.project_name ()),
	install_dir: get_option ('datadir') / 'icons/hicolor/symbolic/apps',
	     rename: '@0@-symbolic.svg'.format (application_id)
)


# Compile symbolic icons as resources
icon_resources = gnome.compile_resources (
	'replay-icon-resources',
	'replay-icon-resources.xml',
)
