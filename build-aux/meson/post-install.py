#!/usr/bin/env python

from os import getenv
from os.path import join
from subprocess import call

prefix = getenv('MESON_INSTALL_PREFIX', '/usr/local')
datadir = join(prefix, 'share')
destdir = getenv('DESTDIR')

if not destdir:
    print('Updating icon cache...')
    call(['gtk-update-icon-cache', '-qtf', join(datadir, 'icons', 'hicolor')])
