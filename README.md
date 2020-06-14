<h1 align="center">
  <img src="data/icons/scalable/apps/com.github.nahuelwexd.Replay.svg"/>
  <br>
  Replay
</h1>
<p align="center">An open source YouTube client for GNOME.</p>
<p align="center">
  <a href="https://github.com/nahuelwexd/replay/actions">
    <img alt="Continuous Integration" src="https://github.com/nahuelwexd/replay/workflows/Continuous%20Integration/badge.svg"/>
  </a>
  <a href="https://stopthemingmy.app">
    <img alt="Please do not theme this app" src="https://stopthemingmy.app/badge.svg"/>
  </a>
  <a href="COPYING">
    <img alt="License" src="https://img.shields.io/github/license/nahuelwexd/replay?label=License&logo=gnu"/>
  </a>
<p>
<p align="center">
  <img alt="UI Concept" src="ui-concept.png"/>
</p>

Replay is a brand new app for GNOME, designed to be a faster and bulletproof
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
development build simply by going to the [actions](https://github.com/nahuelwexd/replay/actions)
tab of this repository, and downloading one of those that have been successfully
generated.

> **NOTE:** You must download the artifact called "Flatpak Bundles", which
contains 2 flatpak files ready to install: the application and the locales

## Build

You want to build this project and maybe contribute to it? Well, this is the
right guide for you. But first, you will need to get an API key for the YouTube
Data API v3. Go to the [Google Developers Console](https://console.console.developers.google.com),
create a new project and get a new API key, then choose the way you want to go
to build the app: [GNOME Builder](#gnome-builder) or [manually](#manually).

### GNOME Builder

The GNOME Builder way is easier than any other, and it's the recommended one.
You just need to:

1. Open GNOME Builder (If you haven't installed GNOME Builder yet, do it from
   [Flathub](https://flathub.org/apps/details/org.gnome.Builder) or from your
   distro repos!)
2. Click on the "Clone repository" button
3. Paste the link to this repo and clone it
4. Create a new file inside `src` and name it `constants.vala`:

   ```vala
   namespace Replay.Constants {

       [CCode (cname = "API_KEY")]
       public const string API_KEY = "your_api_key";
   }
   ```

   Where you need to replace `your_api_key` with the API key that you got from
   the Google Developers Console.

5. Hit the "Run" button (▶)

GNOME Builder would automatically download and install all the needed dependencies,
build the app and run it. Then you can export it as a bundle in order to install
it in your system.

### Manually

> **NOTE:** It is important to use a recent distro instead of an old one, since
this app tries to use the most recent version of each library. It's even possible
that you'll need to build some packages manually.

This way is harder and will vary from one distro to another. Here I'll try to be
as too distro agnostic as possible. First, look for the packages that contains
the following `pkg-config` files:

- `glib-2.0.pc`
- `gobject-2.0.pc`
- `gee-0.8.pc`
- `gio-2.0.pc`
- `libsoup-2.4.pc`
- `gtk+-3.0.pc`
- `libhandy-1.pc`
- `gjson-1.0.pc`

And then install the packages that contains the binaries for `sassc`, `meson`,
`ninja`, `vala` and `git`. Then run these commands on your preferred terminal
emulator:

```shell
git clone https://github.com/nahuelwexd/replay.git
cd replay
meson build --buildtype plain
ninja -C build install
```

Inside of `src`, create a new file called `constants.vala`. It should contains
the following code:

```vala
namespace Replay.Constants {

    [CCode (cname = "API_KEY")]
    public const string API_KEY = "your_api_key";
}
```

Where `your_api_key` should be replaced with the API key that you got from the
Google Developers Console.

## License

This project is licensed under the [GNU General Public License v3](COPYING) or
any later version.

[tl;dr](https://www.tldrlegal.com/l/gpl-3.0): You may copy, distribute and modify
this app as long as you track changes/dates in source files. Any modifications to
GPL-licensed code must also be available under the GPL along with build & install
instructions.
