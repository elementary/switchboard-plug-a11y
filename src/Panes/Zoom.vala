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

public class Accessibility.Panes.Zoom : Categories.Pane {
    private Gtk.Switch zoom;
    private Gtk.Switch follow_mouse;
    private Gtk.ComboBox mouse_tracking;
    private Gtk.ComboBox zoom_position;
    private Gtk.Adjustment zoom_level;
    private Gtk.Switch scrolling;
    private Gtk.Switch show_crosshairs;
    private Gtk.ColorButton crosshair_color;
    private Gtk.Scale ch_thickness;
    private Gtk.Scale ch_opacity;
    private Gtk.Adjustment ch_thickness_adjustment;
    private Gtk.Adjustment ch_opacity_adjustment;

    public Zoom () {
        base (_("Zoom"), "preferences-desktop-accessibility-zoom");
    }

    construct {
          build_ui ();
          setup ();
          connect_signals ();
    }

    private void build_ui () {
        var zoom_label = new Accessibility.Widgets.Label (_("Screen Zoom"));
        var crossh_label = new Accessibility.Widgets.Label (_("Crosshairs"));

        zoom_level = new Gtk.Adjustment   (0, 1, 33, 1, 1, 1);
        ch_thickness_adjustment = new Gtk.Adjustment (0, 2, 18, 2, 2, 2);
        ch_opacity_adjustment = new Gtk.Adjustment   (0, 0,  1.1, 0.1, 0.1, 0.1);

        var screen_box = new Accessibility.Widgets.SettingsBox ();
        zoom = screen_box.add_switch (_("Screen zoom"));

        var zoom_box = new Accessibility.Widgets.SettingsBox ();
        follow_mouse = zoom_box.add_switch (_("Follow mouse cursor"));
        mouse_tracking = zoom_box.add_combo_box (_("Mouse tracking"));
        zoom_position = zoom_box.add_combo_box (_("Zoom position"));
        zoom_box.add_scale (_("Zoom level"), zoom_level);
        scrolling = zoom_box.add_switch (_("Desktop Scrolling"));

        var crossh_box = new Accessibility.Widgets.SettingsBox ();
        crosshair_color = new Gtk.ColorButton ();
        show_crosshairs = crossh_box.add_switch (_("Display crosshairs"));
        crossh_box.add_widget (_("Crosshair color"), crosshair_color);
        ch_thickness = crossh_box.add_scale (_("Crosshair thickness"), ch_thickness_adjustment);
        ch_opacity = crossh_box.add_scale (_("Crosshair opacity"), ch_opacity_adjustment);

        grid.add (screen_box);
        grid.add (zoom_label);
        grid.add (zoom_box);
        grid.add (crossh_label);
        grid.add (crossh_box);

        grid.show_all ();
    }

    private void setup () {
        // Mouse Tracking
        Gtk.ListStore tracking_store = new Gtk.ListStore (1, typeof (string));
        Gtk.TreeIter tracking_iter;

        tracking_store.append (out tracking_iter);
        tracking_store.set (tracking_iter, 0, "Centered");
        tracking_store.append (out tracking_iter);
        tracking_store.set (tracking_iter, 0, "Push");

        mouse_tracking.set_model (tracking_store);
        mouse_tracking.set_active (magnifier_settings.get_tracking ());

        // Zoom position
        Gtk.ListStore position_store = new Gtk.ListStore (1, typeof (string));
        Gtk.TreeIter position_iter;

        position_store.append (out position_iter);
        position_store.set (position_iter, 0, "Fullscreen");
        position_store.append (out position_iter);
        position_store.set (position_iter, 0, "Top Half");
        position_store.append (out position_iter);
        position_store.set (position_iter, 0, "Bottom Half");
        position_store.append (out position_iter);
        position_store.set (position_iter, 0, "Left Half");
        position_store.append (out position_iter);
        position_store.set (position_iter, 0, "Right Half");

        zoom_position.set_model (position_store);
        zoom_position.set_active (magnifier_settings.get_tracking ());

        // Crosshairs color
        crosshair_color.rgba = magnifier_settings.get_crosshairs_color ();
    }

    private void connect_signals () {
        applications_settings.schema.bind ("screen-magnifier-enabled", zoom, "active", SettingsBindFlags.DEFAULT);
        magnifier_settings.schema.bind ("lens-mode", follow_mouse, "active", SettingsBindFlags.DEFAULT);
        magnifier_settings.schema.bind ("mag-factor", zoom_level, "value", SettingsBindFlags.DEFAULT);
        magnifier_settings.schema.bind ("scroll-at-edges", scrolling, "active", SettingsBindFlags.DEFAULT);
        magnifier_settings.schema.bind ("cross-hairs-thickness", ch_thickness_adjustment, "value", SettingsBindFlags.DEFAULT);
        magnifier_settings.schema.bind ("cross-hairs-opacity", ch_opacity_adjustment, "value", SettingsBindFlags.DEFAULT);
        magnifier_settings.schema.bind ("show-cross-hairs", show_crosshairs, "active", SettingsBindFlags.DEFAULT);

        magnifier_settings.schema.bind ("show-cross-hairs", crosshair_color, "sensitive", SettingsBindFlags.GET);
        magnifier_settings.schema.bind ("show-cross-hairs", ch_opacity, "sensitive", SettingsBindFlags.GET);
        magnifier_settings.schema.bind ("show-cross-hairs", ch_thickness, "sensitive", SettingsBindFlags.GET);

        crosshair_color.color_set.connect (() => {
            magnifier_settings.set_crosshairs_color (crosshair_color.rgba);
        });

        mouse_tracking.changed.connect (() => {
            magnifier_settings.set_tracking (mouse_tracking.get_active ());
        });

        zoom_position.changed.connect (() => {
            magnifier_settings.set_position (zoom_position.get_active ());
        });
    }
}
