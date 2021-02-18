#!/usr/bin/env python
'''
YAML to JSON Python script

Highly inspired on https://gitlab.gnome.org/GNOME/geary/-/blob/mainline/build-aux/yaml_to_json.py
'''

import json
import os
import sys

import yaml

_, filename, output, *_ = sys.argv

with open(filename) as file:
	obj = yaml.safe_load(file)

comment = f'/* Automatically generated from {os.path.basename(filename)}, do not modify. */'

with open(output, 'w') as file:
	print(comment, file=file)
	json.dump(obj, file, indent=2)
