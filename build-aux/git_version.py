#!/usr/bin/env python3

from subprocess import check_output, DEVNULL
import sys

try:
    version = str (check_output (
        ['git', 'describe', '--tags', '|', 'sed', '\'s/-/.r/; s/-/./\''],
        stderr=DEVNULL
    ), encoding='UTF-8').strip ()
except:
    try:
        rev_count = str (check_output (
            ['git', 'rev-list', '--count', 'HEAD'],
            stderr=DEVNULL
        ), encoding='UTF-8').strip ()

        rev = str (check_output (
            ['git', 'rev-parse', '--short', 'HEAD'],
            stderr=DEVNULL
        ), encoding='UTF-8').strip ()

        version = 'r%s.%s' % (rev_count, rev)
    except:
        version = sys.argv[1].strip ()

print (version)
