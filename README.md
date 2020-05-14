<h1 align="center">
  <img src="data/icons/scalable/apps/com.github.nahuelwexd.UniTube.svg"/>
  <br>
  UniTube GTK
</h1>
<p align="center">An open source YouTube client for GNOME.</p>
<p align="center">
  <a href="https://github.com/nahuelwexd/UniTube-GTK/actions">
    <img alt="Continuous Integration" src="https://github.com/nahuelwexd/UniTube-GTK/workflows/Continuous%20Integration/badge.svg"/>
  </a>
  <a href="https://stopthemingmy.app">
    <img alt="Please do not theme this app" src="https://stopthemingmy.app/badge.svg"/>
  </a>
  <a href="COPYING">
    <img alt="License" src="https://img.shields.io/github/license/nahuelwexd/UniTube-GTK?label=License&logo=gnu"/>
  </a>
<p>
<p align="center">
  <img alt="UI Concept" src="ui-concept.png"/>
</p>

UniTube GTK is a brand new app for GNOME, designed to be a faster and bulletproof
YouTube client for laptops and phones. You would be able to manage all your
suscriptions and playlists, search for videos and explore the new trendings for
your location (or other locations).

**This project is still under active development, and not yet ready for use.**

## Install

### Stable

Since this project is still under active development, there's no current stable
build. You will see a Flathub link here when there's one 🙂️

### Development

Development builds are automatically generated every time a new change occurs in
this repository, and are marked with a custom icon and style. You can install a
development build simply by going to the [actions](https://github.com/nahuelwexd/UniTube-GTK/actions)
tab of this repository, and downloading one of those that have been successfully
generated.

> **NOTE:** You must download the artifact called "Flatpak Bundles", which
contains 2 flatpak files ready to install: the application and the locales

## Build

You can build this project in two ways: GNOME Builder or manually.

### GNOME Builder

The GNOME Builder way is easier than any other, and it's the recommended one.
You just need to:

- Open GNOME Builder (If you haven't installed GNOME Builder yet, do it from your
  distro repos or from [Flathub](https://flathub.org/apps/details/org.gnome.Builder)!)
- Click on the "Clone repository" button
- Paste the link to this repo and clone it
- Hit the "Run" button (▶)

GNOME Builder would automatically download and install all the needed dependencies,
build the app and run it. Then you can export it as a bundle in order to install
it in your system.

### Manually

You will need to download and install all of these dependencies:

- `gtk+-3.0`
- `libhandy-1`
- `gee-0.8`
- `utlib-0.0`
- `sassc`
- `meson`
- `vala`
- `git` (this is obvious, but still)

Then run these commands on your preferred terminal emulator:

```shell
git clone https://github.com/nahuelwexd/UniTube-GTK.git
cd UniTube-GTK
meson build --buildtype plain
ninja -C build install
```

## License

This project is licensed under the [GNU General Public License v3](COPYING) or
any later version.

[tl;dr](https://www.tldrlegal.com/l/gpl-3.0): You may copy, distribute and modify
this app as long as you track changes/dates in source files. Any modifications to
GPL-licensed code must also be available under the GPL along with build & install
instructions.
