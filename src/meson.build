plug_files = files(
    'Plug.vala',
    'Widgets/SettingBox.vala',
    'Widgets/Label.vala',
    'Widgets/Categories.vala',
    'Panes/Typing.vala',
    'Panes/Pointing.vala',
    'Panes/Keyboard.vala',
    'Panes/Clicking.vala',
    'Panes/Audio.vala',
    'Backend/Settings.vala'
)

switchboard_dep = dependency('switchboard-2.0')

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
    install_dir : join_paths(switchboard_dep.get_pkgconfig_variable('plugsdir'), 'system')
)
