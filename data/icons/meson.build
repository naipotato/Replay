# install app icons
scalable_dir = 'scalable/apps'
install_data(
  scalable_dir / f'@app_id@.svg',
  install_dir : datadir / 'icons/hicolor' / scalable_dir,
)

symbolic_dir = 'symbolic/apps'
install_data(
  symbolic_dir / f'@reverse_dns@-symbolic.svg',

  install_dir : datadir / 'icons/hicolor' / symbolic_dir,
  rename      : f'@app_id@-symbolic.svg',
)

# compile symbolic icons as resources
icon_resources = gnome.compile_resources(
  'replay-icon-resources',
  'replay-icon-resources.xml',
)
