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
    private Gtk.Switch screen_flash;
    private Gtk.Switch read_items;
    private Gtk.Label shortcut_label;

    public Audio () {
        base (_("Audio"), "preferences-desktop-sound");
    }

    construct {
        build_ui ();
        connect_signals ();
    }

    private void build_ui () {
        //var playback_label = new Accessibility.Widgets.Label (_("Playback"));
        var alerts_label = new Accessibility.Widgets.Label (_("Visual Alerts"));
        var reader_label = new Accessibility.Widgets.Label (_("Screen Reader"));
        var audio_settings = new Accessibility.Widgets.LinkLabel (_("Sound settings…"), "switchboard sound");
        audio_settings.vexpand = true;

        //var playback_box = new Accessibility.Widgets.SettingsBox ();
        //var playback = playback_box.add_switch (_("Play stereo audio output as mono"));
        //playback.set_sensitive (false);

        var alerts_box = new Accessibility.Widgets.SettingsBox ();
        screen_flash = alerts_box.add_switch (_("Flash the screen when an alert sound occurs"));

        var reader_box = new Accessibility.Widgets.SettingsBox ();
        shortcut_label = new Gtk.Label (media_keys_settings.clean_screenreader ());
        read_items = reader_box.add_switch (_("Provide audio descriptions for items on the screen"));
        reader_box.add_widget (_("Keyboard shortcut"), shortcut_label);

        //grid.add (playback_label);
        //grid.add (playback_box);
        grid.add (alerts_label);
        grid.add (alerts_box);
        grid.add (reader_label);
        grid.add (reader_box);
        grid.add (audio_settings);

        grid.show_all ();
    }

    private void connect_signals () {
        wm_preferences_settings.schema.bind ("visual-bell", screen_flash, "active", SettingsBindFlags.DEFAULT);
        applications_settings.schema.bind ("screen-reader-enabled", read_items, "active", SettingsBindFlags.DEFAULT);
        
        media_keys_settings.changed.connect (() => {
            shortcut_label.label = media_keys_settings.clean_screenreader ();
        });
    }
}
