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
 * Authored by: Corentin Noël <corentin@elementary.io>
 */
public class Accessibility.Panes.General : Categories.Pane {
    public General () {
        base (_("General"), "preferences-desktop-accessibility");
    }

    construct {
        var a11y_keyboard_label = new Gtk.Label (_("Turn accessibility features on and off using the keyboard:"));
        a11y_keyboard_label.hexpand = true;
        a11y_keyboard_label.halign = Gtk.Align.END;
        var a11y_menu_label = new Gtk.Label (_("Display accessibility menu in panel:"));
        a11y_menu_label.halign = Gtk.Align.END;
        var a11y_keyboard_switch = new Gtk.Switch ();
        var a11y_menu_switch = new Gtk.Switch ();
        var a11y_keyboard_switch_grid = new Gtk.Grid ();
        a11y_keyboard_switch_grid.hexpand = true;
        a11y_keyboard_switch_grid.halign = Gtk.Align.START;
        a11y_keyboard_switch_grid.add (a11y_keyboard_switch);
        var a11y_menu_switch_grid = new Gtk.Grid ();
        a11y_menu_switch_grid.add (a11y_menu_switch);

        grid.attach (a11y_keyboard_label, 0, 0, 1, 1);
        grid.attach (a11y_keyboard_switch_grid, 1, 0, 1, 1);
        grid.attach (a11y_menu_label, 0, 1, 1, 1);
        grid.attach (a11y_menu_switch_grid, 1, 1, 1, 1);

        grid.show_all ();
    }
}
