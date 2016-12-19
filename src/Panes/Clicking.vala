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
    private Gtk.Scale dc_speed;
    private Gtk.Switch ssc_enable;
    private Gtk.Scale ssc_delay;
    private Gtk.Switch hc_enable;
    private Gtk.Scale hc_delay;
    private Gtk.Scale hc_threshold;
    private Gtk.Adjustment dc_speed_adjustment;
    private Gtk.Adjustment ssc_delay_adjustment;
    private Gtk.Adjustment hc_delay_adjustment;
    private Gtk.Adjustment hc_threshold_adjustment;

    public Clicking () {
        base (_("Clicking"), "preferences-desktop-peripherals");
    }

    construct {
        build_ui ();
        connect_signals ();
    }

    private void build_ui () {
        var secondary_label = new Accessibility.Widgets.Label (_("Simulated Secondary Click"));
        var hover_label = new Accessibility.Widgets.Label (_("Hover Click"));
        var mouse_settings_label = new Accessibility.Widgets.LinkLabel (_("Mouse settings…"), "settings://input/mouse");
        mouse_settings_label.vexpand = true;
        
        dc_speed_adjustment = new Gtk.Adjustment (0, 300, 1500, 0.1, 0.1, 0.1);
        ssc_delay_adjustment = new Gtk.Adjustment (0, 0, 2, 0.1, 0.1, 0.1);
        hc_delay_adjustment = new Gtk.Adjustment (0, 0, 2, 0.1, 0.1, 0.1);
        hc_threshold_adjustment = new Gtk.Adjustment (0, 0, 30, 0.1, 0.1, 0.1);

        var click_box = new Accessibility.Widgets.SettingsBox ();
        dc_speed = click_box.add_scale (_("Double-click speed"), dc_speed_adjustment);

        var sim_box = new Accessibility.Widgets.SettingsBox ();
        ssc_enable = sim_box.add_switch (_("Hold primary button to trigger secondary click"));
        ssc_delay = sim_box.add_scale (_("Simulated click delay"), ssc_delay_adjustment);

        var hover_box = new Accessibility.Widgets.SettingsBox ();
        hc_enable = hover_box.add_switch (_("Click when the cursor hovers"));
        hc_delay = hover_box.add_scale (_("Hover delay"), hc_delay_adjustment);
        hc_threshold = hover_box.add_scale (_("Motion threshold"), hc_threshold_adjustment);

        grid.add (click_box);
        grid.add (secondary_label);
        grid.add (sim_box);
        grid.add (hover_label);
        grid.add (hover_box);
        grid.add (mouse_settings_label);
        grid.show_all ();
    }

    private void connect_signals () {
        peripherals_settings.schema.bind ("double-click", dc_speed_adjustment, "value", SettingsBindFlags.DEFAULT);
        mouse_settings.schema.bind ("secondary-click-enabled", ssc_enable, "active", SettingsBindFlags.DEFAULT);
        mouse_settings.schema.bind ("secondary-click-time", ssc_delay_adjustment, "value", SettingsBindFlags.DEFAULT);
        mouse_settings.schema.bind ("dwell-click-enabled", hc_enable, "active", SettingsBindFlags.DEFAULT);
        mouse_settings.schema.bind ("dwell-time", hc_delay_adjustment, "value", SettingsBindFlags.DEFAULT);
        mouse_settings.schema.bind ("dwell-threshold", hc_threshold_adjustment, "value", SettingsBindFlags.DEFAULT);

        mouse_settings.schema.bind ("secondary-click-enabled", ssc_delay, "sensitive", SettingsBindFlags.GET);
        mouse_settings.schema.bind ("dwell-click-enabled", hc_delay, "sensitive", SettingsBindFlags.GET);
        mouse_settings.schema.bind ("dwell-click-enabled", hc_threshold, "sensitive", SettingsBindFlags.GET);
    }
}
