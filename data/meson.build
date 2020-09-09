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

desktop_file = configure_file (
			input: '@0@.desktop.in'.format (rdnn_app_name),
		   output: '@0@.desktop'.format (application_id),
	configuration: desktop_file_conf,
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

# Install icons
install_data ('icons/scalable/apps/@0@.svg'.format (application_id),
	install_dir: get_option ('datadir') / 'icons/hicolor/scalable/apps'
)

install_data ('icons/symbolic/apps/@0@-symbolic.svg'.format (rdnn_app_name),
	install_dir: get_option ('datadir') / 'icons/hicolor/symbolic/apps',
		 rename: '@0@-symbolic.svg'.format (application_id)
)
