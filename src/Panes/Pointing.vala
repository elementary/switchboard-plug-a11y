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
    public Pointing () {
        base (_("Pointing"), "preferences-desktop-accessibility-pointing");
    }

    construct {
        build_ui ();
    }
    
    private void build_ui () {
        var control_label = new Accessibility.Widgets.Label (_("Keypad Control"));
        var speed_adjustment = new Gtk.Adjustment (0, 0, 1, 0.1, 0.1, 0.1);
        
        var cursor_box = new Accessibility.Widgets.SettingsBox ();
        cursor_box.add_combo_box (_("Cursor size"));
        
        var control_box = new Accessibility.Widgets.SettingsBox ();
        control_box.add_switch (_("Control pointer using keypad"));
        control_box.add_scale (_("Cursor speed"), speed_adjustment);
        
        grid.add (cursor_box);
        grid.add (control_label);
        grid.add (control_box);
        grid.show_all ();
        
        
    }
}
