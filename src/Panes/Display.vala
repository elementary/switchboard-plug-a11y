/*
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

public class Accessibility.Panes.Display : Categories.Pane {
    private const string PANEL_SCHEMA = "org.pantheon.desktop.wingpanel";
    public Display () {
        Object (
            label_string: _("Display"),
            icon_name: "video-display"
        );
    }

    construct {
        var color_label = new Accessibility.Widgets.Label (_("Color"));
        var reading_label = new Accessibility.Widgets.Label (_("Reading"));
        var display_settings = new Accessibility.Widgets.LinkLabel (_("Display settings…"), "settings://display");
        display_settings.vexpand = true;

        var color_box = new Accessibility.Widgets.SettingsBox ();

        var hi_contrast = color_box.add_switch (_("High contrast theme"));

        var panel_schema = SettingsSchemaSource.get_default ().lookup (PANEL_SCHEMA, false);
        if (panel_schema!= null) {
            var transparency = color_box.add_switch (_("Panel transparency"));

            var panel_settings = new Settings (PANEL_SCHEMA);
            panel_settings.bind ("use-transparency", transparency, "active", SettingsBindFlags.DEFAULT);
        }

        var reading_box = new Accessibility.Widgets.SettingsBox ();
        var text_size = reading_box.add_combo_box (_("Text size"));

        grid.add (color_label);
        grid.add (color_box);
        grid.add (reading_label);
        grid.add (reading_box);
        grid.add (display_settings);
        grid.show_all ();

        // Text Size
        Gtk.ListStore list_store = new Gtk.ListStore (1, typeof (string));
        Gtk.TreeIter iter;

        list_store.append (out iter);
        list_store.set (iter, 0, _("Normal"));
        list_store.append (out iter);
        list_store.set (iter, 0, _("Large"));
        list_store.append (out iter);
        list_store.set (iter, 0, _("Larger"));

        text_size.set_model (list_store);
        text_size.set_active (deskop_interface_settings.get_text_scale ());

        hi_contrast.state = deskop_interface_settings.get_high_contrast ();

        hi_contrast.state_set.connect ((state) => {
            debug ("State chenged \n");
            deskop_interface_settings.set_high_contrast (state);
            return true;
        });

        text_size.changed.connect (() => {
            deskop_interface_settings.set_text_scale (text_size.get_active ());
        });
    }
}
