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
public class Accessibility.Panes.Keyboard : Categories.Pane {
    public Keyboard () {
        base (_("Keyboard"), "preferences-desktop-keyboard");
    }

    construct {
        build_ui ();
    }
    
    private void build_ui () {
        var lock_label = new Accessibility.Widgets.Label (_("Lock Keys"));
        var modifier_label = new Accessibility.Widgets.Label (_("Modifier Keys"));
                                       
        var lock_box = new Accessibility.Widgets.SettingsBox ();
        lock_box.add_switch (_("Display notifications for lock keys"));
        lock_box.add_switch (_("Beep when a lock key is pressed"));
        
        var modifier_box = new Accessibility.Widgets.SettingsBox ();
        modifier_box.add_switch (_("Use modifier keys in sequence (sticky keys)"));
        modifier_box.add_switch (_("Beep when a modifier key is pressed"));
        
        grid.add (lock_label);
        grid.add (lock_box);
        grid.add (modifier_label);
        grid.add (modifier_box);
        grid.show_all ();
    }
}
