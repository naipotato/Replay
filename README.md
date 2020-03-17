<div align="center">
  <p align="center">
    <img src="data/icons/scalable/apps/repo-logo.svg"/>
    <br>
    An open source YouTube client written in Vala and GTK.
  </p>
</div>
<div align="center">
  <a href="https://github.com/nahuelwexd/unitube-gtk/commits/master">
    <img alt="Flatpak" src="https://github.com/nahuelwexd/unitube-gtk/workflows/Flatpak/badge.svg"/>
  </a>
  <a href="https://stopthemingmy.app/">
    <img alt="Please do not theme this app" src="https://stopthemingmy.app/badge.svg">
  </a>
  <a href="COPYING">
    <img alt="license" src="https://img.shields.io/badge/license-GPL--3.0-orange">
  </a>
</div>

## About
Unitube GTK is a new, open source and cross-platform YouTube client that I
started separately from the main project because .NET does not yet have a
completely mature graphical interface toolkit for Linux.

Since my main developtment environment is Linux, my focus will be mainly on this
project, although due to the similarity of syntax between Vala and C#, I can
easily port my progress to the main project.

## Status
I'm actively working (for now) on an adaptive interface that can be easily used
on phones, laptops and desktops. And soon I will be working on a library called
`utlib`, where I will put everything related to the core of Unitube.

## Build
If you want to build this project, all you need is love ❤️... And the following
dependencies:

- `gee-0.8`
- `libhandy >= 0.0.10`
- `gtk+-3.0 >= 3.24`
- `vala`
- `meson`

... and `git` in order to clone the project.

Then simply follow these commands:

```sh
git clone https://github.com/nahuelwexd/unitube-gtk.git
cd unitube-gtk
meson build --prefix=/usr
ninja -C build

# If you want to install it, just run
ninja -C build install

# Probably you will need to install it in order to run it, until I implement a
# way to load gschemas from a custom location (the build directory).
```

## License
This project is licensed under the [GNU General Public License v3](COPYING).
