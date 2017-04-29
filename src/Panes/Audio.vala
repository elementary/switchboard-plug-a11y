// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2015-2017 elementary LLC. (https://elementary.io)
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
 * Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor,
 * Boston, MA 02110-1301, USA.
 *
 * Authored by: Felipe Escoto <felescoto95@hotmail.com>
 */

public class Accessibility.Panes.Audio : Categories.Pane {
    public Audio () {
        base (_("Audio"), "preferences-desktop-sound");
    }

    construct {
        var alerts_label = new Accessibility.Widgets.Label (_("Visual Alerts"));

        var alerts_box = new Accessibility.Widgets.SettingsBox ();
        var screen_flash = alerts_box.add_switch (_("Flash the screen when an alert sound occurs"));

        var reader_label = new Accessibility.Widgets.Label (_("Screen Reader"));

        var reader_box = new Accessibility.Widgets.SettingsBox ();
        var read_items = reader_box.add_switch (_("Provide audio descriptions for items on the screen"));
        var shortcut_label = new Gtk.Label (media_keys_settings.clean_screenreader ());
        reader_box.add_widget (_("Keyboard shortcut"), shortcut_label);

        var audio_settings = new Accessibility.Widgets.LinkLabel (_("Sound settings…"), "settings://sound");
        audio_settings.vexpand = true;

        grid.add (alerts_label);
        grid.add (alerts_box);
        grid.add (reader_label);
        grid.add (reader_box);
        grid.add (audio_settings);
        grid.show_all ();

        wm_preferences_settings.schema.bind ("visual-bell", screen_flash, "active", SettingsBindFlags.DEFAULT);
        applications_settings.schema.bind ("screen-reader-enabled", read_items, "active", SettingsBindFlags.DEFAULT);

        media_keys_settings.changed.connect (() => {
            shortcut_label.label = media_keys_settings.clean_screenreader ();
        });
    }
}
