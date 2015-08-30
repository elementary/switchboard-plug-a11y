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
public class Accessibility.Panes.General : Categories.Pane {
    private Gtk.Switch keyboard;
    private Gtk.Switch panel;

    public General () {
        base (_("General"), "preferences-desktop-accessibility");
    }

    construct {
        build_ui ();
        connect_signals ();
    }

    private void build_ui () {
        var general = new Accessibility.Widgets.SettingsBox ();
        keyboard = general.add_switch ("Turn accessibility features on and off using the keyboard:");
        panel = general.add_switch ("Display accessibility menu in panel:");

        grid.add (general);

        grid.show_all ();
    }

    private void connect_signals () {
        keyboard_settings.schema.bind ("enable", keyboard, "active", SettingsBindFlags.DEFAULT);
        a11y_settings.schema.bind ("always-show-universal-access-status", panel, "active", SettingsBindFlags.DEFAULT);
    }
}
