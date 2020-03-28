<a href="https://github.com/nahuelwexd/UniTube-GTK/commits/master">
  <img alt="Flatpak" src="https://github.com/nahuelwexd/UniTube-GTK/workflows/Flatpak/badge.svg"/>
</a>
<a href="https://stopthemingmy.app">
  <img alt="Please do not theme this app" src="https://stopthemingmy.app/badge.svg"/>
</a>
<a href="COPYING">
  <img alt="License" src="https://img.shields.io/github/license/nahuelwexd/UniTube-GTK?label=License&logo=gnu"/>
</a>
<p align="center">
  <img src="data/icons/scalable/apps/com.github.nahuelwexd.Unitube.svg"/>
  <h3 align="center">UniTube GTK</h3>
  <p align="center">
    An open source YouTube client written in Vala and GTK.
  </p>
  <img alt="UI Concept" src="ui-concept.png"/>
</p>

## About

UniTube GTK is a new, open source and cross-platform YouTube client that I
started separately from the main project because .NET does not yet have a
completely mature graphical interface toolkit for Linux.

Since my main developtment environment is Linux, my focus will be mainly on this
project, although due to the similarity of syntax between Vala and C#, I can
easily port my progress to the main project.

## Status

I'm actively working (for now) on an adaptive interface that can be easily used
on phones, laptops and desktops. And soon I will be working on a library called
`utlib`, where I will put everything related to the core of UniTube.

## Build

If you want to build this project, all you need is love ❤️... And the following
dependencies:

- `gee-0.8`
- `libhandy` (>= 0.0.10)
- `gtk+-3.0` (>= 3.24)
- `vala`
- `meson`

... and `git` in order to clone the project.

Then simply follow these commands:

```shell
git clone https://github.com/nahuelwexd/UniTube-GTK.git
cd UniTube-GTK
meson build --prefix /usr --buildtype release
ninja -C build
# If you want to install it, just run
ninja -C build install
# Probably you will need to install it in order to run it, until I implement a
# way to load gschemas from a custom location (the build directory).
```

## License

This project is licensed under the [GNU General Public License v3](COPYING).
