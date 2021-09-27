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
	     po_dir: meson.project_source_root () / 'po',
	       type: 'desktop',
	    install: true,
	install_dir: datadir / 'applications'
)


# Verify if the desktop file is valid
desktop_file_validate = find_program ('desktop-file-validate', required: false)

if desktop_file_validate.found ()
	test ('validate-desktop-file', desktop_file_validate,
		args: desktop_file
	)
endif


subdir ('icons')
