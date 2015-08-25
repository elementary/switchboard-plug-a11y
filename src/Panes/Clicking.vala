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
public class Accessibility.Panes.Clicking : Categories.Pane {
    public Clicking () {
        base (_("Clicking"), "preferences-desktop-peripherals");
    }

    construct {
        build_ui ();
    }
    
    private void build_ui () {
        var secondary_label = new Accessibility.Widgets.Label (_("Simulated Secondary Click"));
        var hover_label = new Accessibility.Widgets.Label (_("Hover Click"));
        
        var adjustment = new Gtk.Adjustment (0, 0, 1, 0.1, 0.1, 0.1);
        
        var click_box = new Accessibility.Widgets.SettingsBox ();
        click_box.add_scale (_("Double-click speed"), adjustment);
        
        var sim_box = new Accessibility.Widgets.SettingsBox ();
        sim_box.add_switch (_("Hold primary button to trigger secondary click"));
        sim_box.add_scale (_("Simulated click delay"), adjustment);
        
        var hover_box = new Accessibility.Widgets.SettingsBox ();
        hover_box.add_switch (_("Click when the cursor hovers"));
        hover_box.add_scale (_("Hover delay"), adjustment);
        hover_box.add_scale (_("Motion threshold"), adjustment);
        
        grid.add (click_box);
        grid.add (secondary_label);
        grid.add (sim_box);
        grid.add (hover_label);
        grid.add (hover_box);
        grid.show_all ();
    }
}
