project(
  'app.drey.Replay',
  'vala', 'c',

  default_options : 'warning_level=2',
  license         : 'GPL-3.0-or-later',
  meson_version   : '>=0.59.0',
  version         : '0.1.0',
)

# import modules
gnome = import('gnome')
i18n  = import('i18n')

# common dirs
prefix    = get_option('prefix')
datadir   = prefix / get_option('datadir')
localedir = prefix / get_option('localedir')

# info about the app
profile         = get_option('profile')
app_id_suffix   = profile == 'devel' ? '.Devel' : ''
application_id  = meson.project_name() + app_id_suffix
version         = meson.project_version() + '-${vcs_tag}'
gettext_package = meson.project_name()

# generate a header with the info
config_h_in = configure_file(
  output        : 'config.h.in',
  configuration : {
    'APPLICATION_ID'  : '"' + application_id + '"',
    'VERSION'         : '"' + version + '"',
    'GETTEXT_PACKAGE' : '"' + gettext_package + '"',
    'LOCALEDIR'       : '"' + localedir + '"',
  },
)

vcs_tag(
  command        : ['git', 'rev-parse', '--short', 'HEAD'],
  fallback       : profile,
  input          : config_h_in,
  output         : 'config.h',
  replace_string : '${vcs_tag}',
)

add_project_arguments(
  '-I' + meson.project_build_root(),
  '-DGETTEXT_PACKAGE=' + meson.project_name(),
  '-DG_LOG_DOMAIN="Replay"',

  language : 'c',
)

# add extra type checks in runtime
vala_args = [
  '--enable-checking',
]

if profile == 'devel'
  vala_args += '--define=DEVEL'
endif

add_project_arguments(
  vala_args,
  language : 'vala',
)

# common variables
valac   = meson.get_compiler('vala')
vapidir = meson.project_source_root() / 'vapi'

# dependencies
adwaita_dep = dependency('libadwaita-1', version : '>=1.0', method : 'pkg-config')
config_dep  = valac.find_library('config', dirs : vapidir)
gee_dep     = dependency('gee-0.8', version : '>=0.20', method : 'pkg-config')
gio_dep     = dependency('gio-2.0', version : '>=2.70', method : 'pkg-config')
gjson_dep   = dependency('gjson-1.0', version : '>=1.0', method : 'pkg-config')
soup_dep    = dependency('libsoup-3.0', version : '>=3.0', method : 'pkg-config')

# subdirectories
subdir('data')
subdir('lib')
subdir('src')
subdir('po')

gnome.post_install(
  gtk_update_icon_cache   : true,
  update_desktop_database : true,
)
