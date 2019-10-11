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
public class Accessibility.Panes.Clicking : Categories.Pane {
    public Clicking () {
        Object (
            label_string: _("Clicking"),
            icon_name: "preferences-desktop-peripherals"
        );
    }

    construct {
        var dc_speed_adjustment = new Gtk.Adjustment (0, 300, 1500, 0.1, 0.1, 0.1);
        var hc_delay_adjustment = new Gtk.Adjustment (0, 0, 2, 0.1, 0.1, 0.1);
        var hc_threshold_adjustment = new Gtk.Adjustment (0, 0, 30, 0.1, 0.1, 0.1);

        var click_box = new Accessibility.Widgets.SettingsBox ();
        click_box.add_scale (_("Double-click speed"), dc_speed_adjustment);

        var hover_label = new Granite.HeaderLabel (_("Hover Click"));

        var hover_box = new Accessibility.Widgets.SettingsBox ();
        var hc_enable = hover_box.add_switch (_("Click when the cursor hovers"));
        var hc_delay = hover_box.add_scale (_("Hover delay"), hc_delay_adjustment);
        var hc_threshold = hover_box.add_scale (_("Motion threshold"), hc_threshold_adjustment);

        var mouse_settings_label = new Accessibility.Widgets.LinkLabel (_("Mouse settings…"), "settings://input/mouse");
        mouse_settings_label.vexpand = true;

        grid.add (click_box);
        grid.add (hover_label);
        grid.add (hover_box);
        grid.add (mouse_settings_label);
        grid.show_all ();

        var peripherals_settings = new GLib.Settings ("org.gnome.settings-daemon.peripherals.mouse");
        peripherals_settings.bind ("double-click", dc_speed_adjustment, "value", SettingsBindFlags.DEFAULT);

        var mouse_settings = new GLib.Settings ("org.gnome.desktop.a11y.mouse");
        mouse_settings.bind ("dwell-click-enabled", hc_delay, "sensitive", SettingsBindFlags.GET);
        mouse_settings.bind ("dwell-click-enabled", hc_enable, "active", SettingsBindFlags.DEFAULT);
        mouse_settings.bind ("dwell-click-enabled", hc_threshold, "sensitive", SettingsBindFlags.GET);

        mouse_settings.bind ("dwell-time", hc_delay_adjustment, "value", SettingsBindFlags.DEFAULT);
        mouse_settings.bind ("dwell-threshold", hc_threshold_adjustment, "value", SettingsBindFlags.DEFAULT);
    }
}
