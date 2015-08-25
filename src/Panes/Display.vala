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
public class Accessibility.Panes.Display : Categories.Pane {
    private Gtk.Switch hi_contrast;
    private Gtk.Switch invert;
    private Gtk.Switch grayscale;
    private Gtk.Switch dysexic_font;
    private Gtk.Scale contrast;
    private Gtk.ComboBox text_size;
     
    public Display () {
        base (_("Display"), "video-display");
    }

    construct {
        build_ui ();
        connect_signals ();
    }
    
    private void build_ui () {
        var color_label = new Accessibility.Widgets.Label (_("Color"));
        var reading_label = new Accessibility.Widgets.Label (_("Reading"));

        var color_box = new Accessibility.Widgets.SettingsBox ();
        var contrast_adjustment = new Gtk.Adjustment (0, 0, 1, 0.1, 0.1, 0.1);
                                         
        hi_contrast = color_box.add_switch (_("High contrast theme"));
        invert = color_box.add_switch (_("Invert Colors"));
        grayscale = color_box.add_switch (_("Grayscale"));
        contrast = color_box.add_scale (_("Display contrast"), contrast_adjustment);

        var reading_box = new Accessibility.Widgets.SettingsBox ();
        text_size = reading_box.add_combo_box (_("Text size"));
        dysexic_font = reading_box.add_switch (_("Dyslexic-friendly font"));

        grid.add (color_label);
        grid.add (color_box);
        grid.add (reading_label);
        grid.add (reading_box);

        grid.show_all ();
    } 
    
    private void connect_signals () {
        
    }
}
