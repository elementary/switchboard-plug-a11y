plug_files = files(
    'Plug.vala',
    'Widgets/SettingBox.vala',
    'Widgets/Label.vala',
    'Widgets/Categories.vala',
    'Panes/Typing.vala',
    'Panes/Keyboard.vala',
    'Panes/Audio.vala'
)

switchboard_dep = dependency('switchboard-2.0')
switchboard_plugsdir = switchboard_dep.get_pkgconfig_variable('plugsdir', define_variable: ['libdir', libdir])

shared_module(
    meson.project_name(),
    plug_files,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gio-2.0'),
        dependency('gobject-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        switchboard_dep
    ],
    install: true,
    install_dir : join_paths(switchboard_plugsdir, 'system')
)
