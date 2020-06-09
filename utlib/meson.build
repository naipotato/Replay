sources = files (
    'data/thumbnail.vala',
    'data/video.vala',
    'data/video-localization.vala',
    'data/video-snippet.vala',

    'errors/parser-error.vala',
    'errors/request-error.vala',

    'requests/request.vala',
    'requests/video-list-request.vala',

    'resources/videos-resource.vala',

    'responses/list-response.vala',
    'responses/page-info.vala',
    'responses/video-list-response.vala',

    'services/parameter.vala',
    'services/parameters-service.vala',

    'client.vala'
)


utlib_version = meson.project_version ()
version_array = utlib_version.split ('.')
utlib_major_version = version_array[0].to_int ()
utlib_minor_version = version_array[1].to_int ()
utlib_micro_version = version_array[2].to_int ()

utlib_api_version = '@0@.0'.format (utlib_major_version)
utlib_api_name = '@0@-@1@'.format (meson.project_name (), utlib_api_version)
utlib_gi_name = 'Utlib-@0@'.format (utlib_api_version)

utlib_header = '@0@.h'.format (meson.project_name ())
utlib_vapi = '@0@.vapi'.format (utlib_api_name)
utlib_gir = '@0@.gir'.format (utlib_gi_name)
utlib_typelib = '@0@.typelib'.format (utlib_gi_name)
utlib_pc = '@0@.pc'.format (utlib_api_name)
utlib_deps = '@0@.deps'.format (utlib_api_name)


dependencies = [
    glib_dep,
    gobject_dep,
    gee_dep,
    gio_dep,
    soup_dep,
    gjson_dep
]


utlib = library (
    meson.project_name (),
    sources,

     vala_header: utlib_header,
       vala_vapi: utlib_vapi,
        vala_gir: utlib_gir,
    dependencies: dependencies,
         install: true,
     install_dir: [true, true, true, true]
)


g_ir_compiler = find_program ('g-ir-compiler')

custom_target (
    utlib_typelib,
    command: [
        g_ir_compiler,
        '--shared-library',
        utlib.full_path (),
        '--output',
        '@OUTPUT@',
        meson.current_build_dir () / utlib_gir
    ],

         output: utlib_typelib,
        depends: utlib,
        install: true,
    install_dir: get_option ('libdir') / 'girepository-1.0'
)


utlib_dep = declare_dependency (
              link_with: utlib,
           dependencies: dependencies,
    include_directories: [include_directories ('.')]
)


pkg = import ('pkgconfig')

pkg.generate (utlib,
       requires: soup_dep,
    description: 'Yet another wrapper to the YouTube Data API v3',
       filebase: utlib_api_name,
            url: 'https://github.com/nahuelwexd/UTLib'
)


requires = []

foreach dependency : dependencies
    requires += dependency.name ()
endforeach

deps_conf = configuration_data ()
deps_conf.set ('deps', '\n'.join (requires))

configure_file (
            input: 'deps.meson',
           output: utlib_deps,
    configuration: deps_conf,
          install: true,
      install_dir: get_option ('datadir') / 'vala' / 'vapi'
)
