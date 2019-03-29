project (
    'unitube-gtk',
    ['c', 'vala'],
    version: '0.1.0'
)

i18n = import ('i18n')

app_id = 'com.nucleuxsoft.UniTube'

podir = join_paths (meson.source_root (), 'po')

prefix = get_option ('prefix')
datadir = join_paths (prefix, get_option ('datadir'))

vul_proj = subproject ('vul')

subdir ('data')
subdir ('src')

meson.add_install_script (join_paths ('build-aux', 'post_install.py'))
