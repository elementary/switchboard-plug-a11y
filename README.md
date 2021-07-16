# Switchboard Universal Access Plug
[![Translation status](https://l10n.elementary.io/widgets/switchboard/-/switchboard-plug-a11y/svg-badge.svg)](https://l10n.elementary.io/engage/switchboard/?utm_source=widget)

![screenshot](data/screenshot-audio.png?raw=true)

## Building and Installation

You'll need the following dependencies:

* libswitchboard-2.0-dev
* libgranite-dev
* libgtk-3-dev
* meson
* valac (>= 0.22)

Run `meson` to configure the build environment and then `ninja` to build

    meson build --prefix=/usr
    cd build
    ninja

To install, use `ninja install`

    sudo ninja install
