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
public class Accessibility.Panes.Keyboard : Categories.Pane {
    // private Gtk.Switch lk_notification;
    private Gtk.Switch lk_beep;
    private Gtk.Switch mk_enable;
    private Gtk.Switch mk_beep;

    public Keyboard () {
        base (_("Keyboard"), "preferences-desktop-keyboard");
    }

    construct {
        build_ui ();
        connect_signals ();
    }

    private void build_ui () {
        var lock_label = new Accessibility.Widgets.Label (_("Lock Keys"));
        var modifier_label = new Accessibility.Widgets.Label (_("Modifier Keys"));
        var kb_settings_label = new Accessibility.Widgets.LinkLabel (_("Keyboard settings..."), "settings://input/keyboard/behavior");
        kb_settings_label.vexpand = true;

        var lock_box = new Accessibility.Widgets.SettingsBox ();
        // lk_notification = lock_box.add_switch (_("Display notifications for lock keys"));
        lk_beep = lock_box.add_switch (_("Beep when a lock key is pressed"));

        var modifier_box = new Accessibility.Widgets.SettingsBox ();
        mk_enable = modifier_box.add_switch (_("Use modifier keys in sequence (sticky keys)"));
        mk_beep = modifier_box.add_switch (_("Beep when a modifier key is pressed"));

        grid.add (lock_label);
        grid.add (lock_box);
        grid.add (modifier_label);
        grid.add (modifier_box);
        grid.add (kb_settings_label);
        grid.show_all ();
    }

    private void connect_signals () {
        // lk_notification.set_sensitive (false);
        keyboard_settings.schema.bind ("togglekeys-enable", lk_beep, "active", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("stickykeys-enable", mk_enable, "active", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("stickykeys-modifier-beep", mk_beep, "active", SettingsBindFlags.DEFAULT);

        keyboard_settings.schema.bind ("stickykeys-enable", mk_beep, "sensitive", SettingsBindFlags.GET);
    }
}
