project (
    'unitube-gtk',
    ['c', 'vala'],
    version: '0.1.0',
    license: 'GPL-3.0-or-later'
)

app_id = 'com.nucleuxsoft.UniTube'

i18n = import ('i18n')
gnome = import ('gnome')

vul_proj = subproject ('vul')

glib_dep = dependency ('glib-2.0')
gobject_dep = dependency ('gobject-2.0')
gtk_dep = dependency ('gtk+-3.0')
gee_dep = dependency ('gee-0.8')
soup_dep = dependency ('libsoup-2.4')
handy_dep = dependency ('libhandy-0.0')
gjson_dep = vul_proj.get_variable ('gjson_dep')

podir = join_paths (meson.source_root (), 'po')

prefix = get_option ('prefix')
datadir = join_paths (prefix, get_option ('datadir'))

add_project_arguments (
    '-DHANDY_USE_UNSTABLE_API',
    language: 'c'
)

subdir ('data')
subdir ('src')

meson.add_install_script (join_paths ('build-aux', 'post_install.py'))
