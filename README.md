<h1 align="center">
    <img alt="Project logo" src="data/icons/scalable/apps/com.github.nahuelwexd.Replay.svg">
    <br>
    Replay
</h1>

<p align="center">
    An open source YouTube client for GNOME
</p>

<p align="center">
    <a href="https://github.com/nahuelwexd/Replay/actions">
        <img alt="Continuous integration badge" src="https://github.com/nahuelwexd/Replay/workflows/Continuous%20Integration/badge.svg">
    </a>
    <a href="https://stopthemingmy.app">
        <img alt="Please do not theme this app" src="https://stopthemingmy.app/badge.svg">
    </a>
    <a href="COPYING">
        <img alt="License" src="https://img.shields.io/github/license/nahuelwexd/Replay?label=License&logo=gnu">
    </a>
</p>

![UI Mockup](ui-mockup.png)

> **IMPORTANT:** This project is Work in Progress (WIP). It's still on early stages of development and not yet ready for daily use.

Replay is a brand new app for GNOME, designed to be a faster and bulletproof YouTube client for laptops (and phones in the future). You would be able to manage all your subscriptions and playlists, search for videos and explore the new trendings for your location.

## Install

### Stable

Since this project is still under active development, there's no current stable build. You'll see a Flathub badge here when there's one.

### Development

Development builds are automatically generated every time a new change lands on the `master` branch, and are marked with a custom icon and style. You can install a development build simply by going to the [actions](https://github.com/nahuelwexd/Replay/actions) tab of this repository, and downloading one of those that have been successfully generated.

> **NOTE:** You must download the artifact called "Flatpak Bundles", which contains 2 flatpak files ready to install: the application and the locales.

## Build

You want to build this project and maybe contribute to it? Great! 🎉

There're two ways to build this app: using [GNOME Builder](#gnome-builder) (the recommended one) and [manually](#manually).

### GNOME Builder

The GNOME Builder way is easier than any other, and it's the way to go when developing any GNOME app. You just need to:

- Open GNOME Builder (If you haven't installed yet, do it from [Flathub](https://flathub.org/apps/details/org.gnome.Builder) or from your distro repos!).

- Click on the "Clone Repository..." button.

- Paste the link to this repo and clone it.

- Hit the "Run" button (▶️).

GNOME Builder would automatically download and install all the needed dependencies, build the app and run it. Then you can export it as a bundle in order to install it in your system.

### Manually

> **NOTE:** It is important to use a recent distro instead of an old one, since this app tries to use the most recent version of each library. It's even possible that you'll need to build some packages manually.

This way is harder and will vary from one distro to another. Here I'll try to be as too distro agnostic as possible. First, look for the packages that contains the following `pkg-config` files:

- `gee-0.8`

- `gtk4`

- `libgda-5.0`

- `libxml-2.0`

And then install the packages that contains the binaries for `sassc`, `meson`, `ninja`, `valac` and `git`. Then run these commands on your preferred terminal emulator:

```shell
git clone https://github.com/nahuelwexd/Replay.git
cd Replay
meson build --buildtype plain
ninja -C build install
```

## License

This project is licensed under the [GNU General Public License v3](COPYING) or any later version.

[tl;dr](https://www.tldrlegal.com/l/gpl-3.0): You may copy, distribute and modify this app as long as you track changes/dates in source files. Any modifications to GPL-licensed code must also be available under the GPL along with build & install instructions.
