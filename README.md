# Switchboard Universal Access Plug
[![l10n](https://l10n.elementary.io/widgets/switchboard/switchboard-plug-a11y/svg-badge.svg)](https://l10n.elementary.io/projects/switchboard/switchboard-plug-a11y)

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
