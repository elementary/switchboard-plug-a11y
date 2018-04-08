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
public class Accessibility.Panes.Pointing : Categories.Pane {
    public Pointing () {
        Object (
            label_string: _("Pointing"),
            icon_name: "preferences-desktop-accessibility-pointing"
        );
    }

    construct {
        var control_label = new Accessibility.Widgets.Label (_("Keypad Control"));
        var speed_adjustment = new Gtk.Adjustment (0, 0, 50, 1, 1, 1);

        var mouse_settings_label = new Accessibility.Widgets.LinkLabel (_("Mouse settings…"), "settings://input/mouse");
        mouse_settings_label.vexpand = true;

        var control_box = new Accessibility.Widgets.SettingsBox ();
        var keypad_control = control_box.add_switch (_("Control pointer using keypad"));
        var speed_scale = control_box.add_scale (_("Cursor speed"), speed_adjustment);

        grid.add (control_label);
        grid.add (control_box);
        grid.add (mouse_settings_label);
        grid.show_all ();

        // Text Size
        Gtk.ListStore list_store = new Gtk.ListStore (1, typeof (string));
        Gtk.TreeIter iter;

        list_store.append (out iter);
        list_store.set (iter, 0, _("Normal"));
        list_store.append (out iter);
        list_store.set (iter, 0, _("Large"));
        list_store.append (out iter);
        list_store.set (iter, 0, _("Larger"));

        keyboard_settings.schema.bind ("mousekeys-enable", keypad_control, "active", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("mousekeys-max-speed", speed_adjustment, "value", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("mousekeys-enable", speed_scale, "sensitive", SettingsBindFlags.GET);
    }
}
