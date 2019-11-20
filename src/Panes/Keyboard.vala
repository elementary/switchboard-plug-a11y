// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2015-2018 elementary LLC. (https://elementary.io)
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
    public Keyboard () {
        Object (
            label_string: _("Keyboard"),
            icon_name: "preferences-desktop-keyboard"
        );
    }

    construct {
        var lock_label = new Granite.HeaderLabel (_("Lock Keys"));
        var modifier_label = new Granite.HeaderLabel (_("Modifier Keys"));
        var kb_settings_label = new Accessibility.Widgets.LinkLabel (_("Keyboard settings…"), "settings://input/keyboard/behavior");
        kb_settings_label.vexpand = true;

        var lock_box = new Accessibility.Widgets.SettingsBox ();
        var lk_beep = lock_box.add_switch (_("Beep when a lock key is pressed"));

        var modifier_box = new Accessibility.Widgets.SettingsBox ();
        var mk_enable = modifier_box.add_switch (_("Use modifier keys in sequence (sticky keys)"));
        var mk_beep = modifier_box.add_switch (_("Beep when a modifier key is pressed"));

        grid.add (lock_label);
        grid.add (lock_box);
        grid.add (modifier_label);
        grid.add (modifier_box);
        grid.add (kb_settings_label);
        grid.show_all ();

        Accessibility.Plug.keyboard_settings.bind ("togglekeys-enable", lk_beep, "active", SettingsBindFlags.DEFAULT);
        Accessibility.Plug.keyboard_settings.bind ("stickykeys-enable", mk_enable, "active", SettingsBindFlags.DEFAULT);
        Accessibility.Plug.keyboard_settings.bind ("stickykeys-modifier-beep", mk_beep, "active", SettingsBindFlags.DEFAULT);

        Accessibility.Plug.keyboard_settings.bind ("stickykeys-enable", mk_beep, "sensitive", SettingsBindFlags.GET);
    }
}
