// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2015-2018 elementary LLC. (https://elementary.io)
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
    private static GLib.Settings media_keys_settings;

    private string _screenreader_shortcut_keys = "";
    public string screenreader_shortcut_keys {
        get {
            string?[] granite_accel_strings = null;
            foreach (var key in media_keys_settings.get_strv ("screenreader")) {
                granite_accel_strings += Granite.accel_to_string (key);
            }

            _screenreader_shortcut_keys = string.joinv (_(", "), granite_accel_strings);
            return _screenreader_shortcut_keys;
        }
    }

    public Audio () {
        Object (
            label_string: _("Audio"),
            icon_name: "preferences-desktop-sound"
        );
    }

    static construct {
        media_keys_settings = new GLib.Settings ("org.gnome.settings-daemon.plugins.media-keys");
    }

    construct {
        var reader_label = new Granite.HeaderLabel (_("Screen Reader"));

        var reader_box = new Accessibility.Widgets.SettingsBox ();
        var read_items = reader_box.add_switch (_("Provide audio descriptions for items on the screen"));
        var shortcut_label = new Gtk.Label (screenreader_shortcut_keys);
        reader_box.add_widget (_("Keyboard shortcut"), shortcut_label);

        var audio_settings = new Gtk.LinkButton.with_label ("settings://sound", _("Sound settings…")) {
            halign = Gtk.Align.END,
            valign = Gtk.Align.END,
            hexpand = true,
            vexpand = true
        };

        box.append (reader_label);
        box.append (reader_box);
        box.append (audio_settings);

        Accessibility.Plug.applications_settings.bind ("screen-reader-enabled", read_items, "active", SettingsBindFlags.DEFAULT);

        media_keys_settings.changed.connect (() => {
            shortcut_label.label = screenreader_shortcut_keys;
        });
    }
}
