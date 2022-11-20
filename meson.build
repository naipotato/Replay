project(
  'replay',
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
rdnn_app_name   = 'app.drey.Replay'
app_id_suffix   = profile == 'devel' ? '.Devel' : ''
application_id  = f'@rdnn_app_name@@app_id_suffix@'
version         = meson.project_version()
gettext_package = meson.project_name()

# determine vcs tag to use
git     = find_program('git', required : false)
vcs_tag = profile # fallback

if git.found()
  result  = run_command(git, 'rev-parse', '--short', 'HEAD', check : false)
  vcs_tag = result.returncode() == 0 ? result.stdout().strip() : profile
endif

# generate a header with the info
configure_file(
  output        : 'config.h',
  configuration : {
    'APPLICATION_ID'  : f'"@application_id@"',
    'VERSION'         : f'"@version@-@vcs_tag@"',
    'GETTEXT_PACKAGE' : f'"@gettext_package@"',
    'LOCALEDIR'       : f'"@localedir@"',
  },
)

# add some extra arguments
add_project_arguments(
  '--enable-checking',
  '--nostdpkg',
  '--define=' + profile.to_upper(),

  language : 'vala',
)

add_project_arguments(
  '-I' + meson.project_build_root(),
  f'-DGETTEXT_PACKAGE=@gettext_package@',
  '-DG_LOG_DOMAIN="Replay"',

  language : 'c',
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
