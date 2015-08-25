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
public class Accessibility.Panes.Display : Categories.Pane {
    public Display () {
        base (_("Display"), "video-display");
    }

    construct {
        build_ui ();
    }
    
    private void build_ui () {
        var color_label = new Accessibility.Widgets.Label (_("Color"));
        var reading_label = new Accessibility.Widgets.Label (_("Reading"));

        var color_box = new Accessibility.Widgets.SettingsBox ();
        var contrast_adjustment = new Gtk.Adjustment (0, 0, 1, 0.1, 0.1, 0.1);
                                         
        color_box.add_switch (_("High contrast theme"));
        color_box.add_switch (_("Invert Colors"));
        color_box.add_switch (_("Grayscale"));
        color_box.add_scale (_("Display contrast"), contrast_adjustment);

        var reading_box = new Accessibility.Widgets.SettingsBox ();
        reading_box.add_switch (_("Text size"));
        reading_box.add_switch (_("Dyslexic-friendly font"));

        grid.add (color_label);
        grid.add (color_box);
        grid.add (reading_label);
        grid.add (reading_box);

        grid.show_all ();
    }
}
