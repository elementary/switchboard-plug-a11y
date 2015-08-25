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
public class Accessibility.Panes.Typing : Categories.Pane {
    public Typing () {
        base (_("Typing"), "input-keyboard");
    }

    construct {
          build_ui ();   
    }
    
    private void build_ui () {
        var delay_label = new Accessibility.Widgets.Label (_("Typing Delays"));
        var typing_label = new Accessibility.Widgets.Label (_("Fast Typing"));
        
        var delay_adjustment = new Gtk.Adjustment (0, 0, 1, 0.1, 0.1, 0.1);
                                       
        var screen_box = new Accessibility.Widgets.SettingsBox ();
        screen_box.add_switch (_("On-screen keyboard"));
        
        var delay_box = new Accessibility.Widgets.SettingsBox ();
        delay_box.add_switch (_("Delay between key presses (slow keys)"));
        delay_box.add_switch (_("Beep when a key is pressed"));
        delay_box.add_switch (_("Beep when a key is accepted"));
        delay_box.add_switch (_("Beep when a key is rejected"));
        delay_box.add_scale (_("Delay length"), delay_adjustment);
        
        var typing_box = new Accessibility.Widgets.SettingsBox ();
        typing_box.add_switch (_("Ignore fast duplicate keypresses (bounce keys)"));
        typing_box.add_switch (_("Beep when a key is rejected"));
        typing_box.add_scale (_("Delay length"), delay_adjustment);
        
        grid.add (screen_box);
        grid.add (delay_label);
        grid.add (delay_box);
        grid.add (typing_label);
        grid.add (typing_box);
        
        grid.show_all ();
    }
}
