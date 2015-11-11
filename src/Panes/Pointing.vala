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
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * Authored by: Felipe Escoto <felescoto95@hotmail.com>
 */
public class Accessibility.Panes.Pointing : Categories.Pane {
    private Gtk.ComboBox cursor_size;
    private Gtk.Switch keypad_control;
    private Gtk.Scale speed_scale;
    private Gtk.Adjustment speed_adjustment;
    public Pointing () {
        base (_("Pointing"), "preferences-desktop-accessibility-pointing");
    }

    construct {
        build_ui ();
        setup ();
        connect_signals ();
    }

    private void build_ui () {
        var control_label = new Accessibility.Widgets.Label (_("Keypad Control"));
        speed_adjustment = new Gtk.Adjustment (0, 0, 50, 1, 1, 1);
        
        var mouse_settings_label = new Accessibility.Widgets.LinkLabel (_("Mouse settings…"), "switchboard -o pantheon-mouse-touchpad");
        mouse_settings_label.vexpand = true;
        
        //var cursor_box = new Accessibility.Widgets.SettingsBox ();
        //cursor_size = cursor_box.add_combo_box (_("Cursor size"));

        var control_box = new Accessibility.Widgets.SettingsBox ();
        keypad_control = control_box.add_switch (_("Control pointer using keypad"));
        speed_scale = control_box.add_scale (_("Cursor speed"), speed_adjustment);

        //grid.add (cursor_box);
        grid.add (control_label);
        grid.add (control_box);
        grid.add (mouse_settings_label);
        grid.show_all ();
    }

    private void setup () {
        // Text Size
        Gtk.ListStore list_store = new Gtk.ListStore (1, typeof (string));
        Gtk.TreeIter iter;

        list_store.append (out iter);
        list_store.set (iter, 0, "Normal");
        list_store.append (out iter);
        list_store.set (iter, 0, "Large");
        list_store.append (out iter);
        list_store.set (iter, 0, "Larger");

        cursor_size.set_model (list_store);
        cursor_size.set_active (1);
        cursor_size.set_sensitive (false);
    }

    private void connect_signals () {
        keyboard_settings.schema.bind ("mousekeys-enable", keypad_control, "active", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("mousekeys-max-speed", speed_adjustment, "value", SettingsBindFlags.DEFAULT);
        keyboard_settings.schema.bind ("mousekeys-enable", speed_scale, "sensitive", SettingsBindFlags.GET);
    }
}
