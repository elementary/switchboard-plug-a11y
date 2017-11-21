// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2015 Pantheon Developers (https://launchpad.net/switchboardswitchboard-plug-a11y)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor,
 * Boston, MA 02110-1301, USA.
 *
 * Authored by: Felipe Escoto <felescoto95@hotmail.com>
 */
public class Accessibility.Panes.Typing : Granite.SettingsPage {
    private Gtk.Switch screen_keyboard;
    private Gtk.Switch sk_enable;
    private Gtk.Switch sk_pressed;
    private Gtk.Switch sk_accepted;
    private Gtk.Switch sk_rejected;
    private Gtk.Switch bk_enable;
    private Gtk.Switch bk_rejected;
    private Gtk.Scale sk_delay;
    private Gtk.Scale bk_delay;
    private Gtk.Adjustment sk_delay_adjustment;
    private Gtk.Adjustment bk_delay_adjustment;

    public Typing () {
        Object (
            header: _("Interaction"),
            icon_name: "input-keyboard",
            title: _("Typing")
        );
    }

    construct {
          build_ui ();
          connect_signals ();
    }

    private void build_ui () {
        var delay_label = new Accessibility.Widgets.Label (_("Typing Delays"));
        var typing_label = new Accessibility.Widgets.Label (_("Fast Typing"));
        var onboard_settings_label = new Gtk.LinkButton.with_label ("", _("On-screen keyboard settings..."));
        onboard_settings_label.halign = Gtk.Align.END;
        onboard_settings_label.clicked.connect (() => {
            try {
                var appinfo = AppInfo.create_from_commandline ("onboard-settings", null, AppInfoCreateFlags.NONE);
                appinfo.launch (null, null);
            } catch (Error e) {
                warning ("%s\n", e.message);
            }
        });

        var kb_settings_label = new Accessibility.Widgets.LinkLabel (_("Keyboard settings..."), "settings://input/keyboard/behavior");
        kb_settings_label.vexpand = true;

        sk_delay_adjustment = new Gtk.Adjustment (0, 0, 2001, 1, 1, 1);
        bk_delay_adjustment = new Gtk.Adjustment (0, 0, 2001, 1, 1, 1);

        var screen_box = new Accessibility.Widgets.SettingsBox ();
        screen_keyboard = screen_box.add_switch (_("On-screen keyboard"));

        var delay_box = new Accessibility.Widgets.SettingsBox ();
        sk_enable = delay_box.add_switch (_("Delay between key presses (slow keys)"));
        sk_pressed = delay_box.add_switch (_("Beep when a key is pressed"));
        sk_accepted = delay_box.add_switch (_("Beep when a key is accepted"));
        sk_rejected = delay_box.add_switch (_("Beep when a key is rejected"));
        sk_delay = delay_box.add_scale (_("Delay length"), sk_delay_adjustment);

        var typing_box = new Accessibility.Widgets.SettingsBox ();
        bk_enable = typing_box.add_switch (_("Ignore fast duplicate keypresses (bounce keys)"));
        bk_rejected = typing_box.add_switch (_("Beep when a key is rejected"));
        bk_delay = typing_box.add_scale (_("Delay length"), bk_delay_adjustment);

        var grid = new Gtk.Grid  ();
        grid.margin = 24;
        grid.orientation = Gtk.Orientation.VERTICAL;
        grid.row_spacing = 12;
        grid.add (screen_box);
        grid.add (onboard_settings_label);
        grid.add (delay_label);
        grid.add (delay_box);
        grid.add (typing_label);
        grid.add (typing_box);
        grid.add (kb_settings_label);

        add (grid);
    }

    private void connect_signals () {
        applications_settings.schema.bind ("screen-keyboard-enabled", screen_keyboard, "active", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("slowkeys-enable", sk_enable, "active", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("slowkeys-beep-press", sk_pressed, "active", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("slowkeys-beep-accept", sk_accepted, "active", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("slowkeys-beep-reject", sk_rejected, "active", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("slowkeys-delay", sk_delay_adjustment, "value", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("bouncekeys-enable", bk_enable, "active", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("bouncekeys-beep-reject", bk_rejected, "active", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("bouncekeys-delay", bk_delay_adjustment, "value", SettingsBindFlags.DEFAULT);

        keyboard_settings.schema.bind ("slowkeys-enable", sk_pressed, "sensitive", SettingsBindFlags.GET);
        keyboard_settings.schema.bind ("slowkeys-enable", sk_accepted, "sensitive", SettingsBindFlags.GET);
        keyboard_settings.schema.bind ("slowkeys-enable", sk_rejected, "sensitive", SettingsBindFlags.GET);
        keyboard_settings.schema.bind ("slowkeys-enable", sk_delay, "sensitive", SettingsBindFlags.GET);
        keyboard_settings.schema.bind ("bouncekeys-enable", bk_rejected, "sensitive", SettingsBindFlags.GET);
        keyboard_settings.schema.bind ("bouncekeys-enable", bk_delay, "sensitive", SettingsBindFlags.GET);
    }
}
