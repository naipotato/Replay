<h1 align="center">
  <img src="data/icons/scalable/apps/com.github.nahuelwexd.UniTube.svg"/>
  <br>
  UniTube GTK
</h1>
<p align="center">An open source YouTube client for GNOME.</p>
<p align="center">
  <a href="https://github.com/nahuelwexd/UniTube-GTK/commits/master">
    <img alt="Flatpak" src="https://github.com/nahuelwexd/UniTube-GTK/workflows/Flatpak/badge.svg"/>
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

You would be able to install this from Flathub soon!

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

This project is licensed under the [GNU General Public License v3](COPYING).
