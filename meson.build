project('replay', 'vala', 'c',
  default_options : { 'warning_level': '2' },
  license         : 'GPL-3.0-or-later',
  license_files   : 'COPYING',
  meson_version   : '>=1.2',
  version         : '0.1.0',
)

gnome = import('gnome')
i18n  = import('i18n')

prefix    = get_option('prefix')
datadir   = prefix / get_option('datadir')
localedir = prefix / get_option('localedir')

profile       = get_option('profile')
reverse_dns   = 'app.drey.Replay'
app_id_suffix = profile == 'devel' ? '.Devel' : ''
app_id        = reverse_dns + app_id_suffix
version       = meson.project_version() + '-@VCS_TAG@'
gettext_pkg   = meson.project_name()

subdir('data')
subdir('src')
subdir('po')

gnome.post_install(
  gtk_update_icon_cache   : true,
  update_desktop_database : true,
)
