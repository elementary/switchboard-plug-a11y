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
public class Accessibility.Panes.Audio : Categories.Pane {
    public Audio () {
        base (_("Audio"), "preferences-desktop-sound");
    }

    construct {
        build_ui ();
    }
    
    private void build_ui () {
        var playback_label = new Accessibility.Widgets.Label (_("Playback"));
        var alerts_label = new Accessibility.Widgets.Label (_("Visual Alerts"));
        var reader_label = new Accessibility.Widgets.Label (_("Screen Reader"));

        var playback_box = new Accessibility.Widgets.SettingsBox ();
        playback_box.add_switch (_("Play stereo audio output as mono"));
        
        var alerts_box = new Accessibility.Widgets.SettingsBox ();
        alerts_box.add_switch (_("Flash the screen when an alert sound occurs"));
        
        var reader_box = new Accessibility.Widgets.SettingsBox ();
        reader_box.add_switch (_("Provide audio descriptions for items on the screen"));
        reader_box.add_widget (_("Keyboard shortcut"), new Gtk.Label ("Alt+Super+S"));
        
        grid.add (playback_label);
        grid.add (playback_box);
        grid.add (alerts_label);
        grid.add (alerts_box);
        grid.add (reader_label);
        grid.add (reader_box);
        
        grid.show_all ();
    }
}
