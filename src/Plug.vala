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
 * Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor,
 * Boston, MA 02110-1301, USA.
 *
 * Authored by: Corentin Noël <corentin@elementary.io>
 */
namespace Accessibility {
    public static Plug plug;

    public Accessibility.Backend.Keyboard           keyboard_settings;
    public Accessibility.Backend.A11y               a11y_settings;
    public Accessibility.Backend.Magnifier          magnifier_settings;
    public Accessibility.Backend.Applications       applications_settings;
    public Accessibility.Backend.WmPreferences      wm_preferences_settings;
    public Accessibility.Backend.Peripherals        peripherals_settings;
    public Accessibility.Backend.Mouse              mouse_settings;
    public Accessibility.Backend.MediaKeys          media_keys_settings;
    public Settings? animations_settings;

    public class Plug : Switchboard.Plug {
        Gtk.Paned paned;
        Accessibility.Categories categories;

        public Plug () {
            var settings = new Gee.TreeMap<string, string?> (null, null);
            settings.set ("universal-access", null);

            Object (category: Category.SYSTEM,
                    code_name: "io.elementary.switchboard.a11y",
                    display_name: _("Universal Access"),
                    description: _("Configure accessibility features"),
                    icon: "preferences-desktop-accessibility",
                    supported_settings: settings);
            plug = this;
        }

        public override Gtk.Widget get_widget () {
            if (paned == null) {
                keyboard_settings =         new Accessibility.Backend.Keyboard ();
                a11y_settings =             new Accessibility.Backend.A11y ();
                magnifier_settings =        new Accessibility.Backend.Magnifier ();
                applications_settings =     new Accessibility.Backend.Applications ();
                wm_preferences_settings =   new Accessibility.Backend.WmPreferences ();
                peripherals_settings =      new Accessibility.Backend.Peripherals ();
                mouse_settings =            new Accessibility.Backend.Mouse ();
                media_keys_settings =       new Accessibility.Backend.MediaKeys ();

                paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
                categories = new Categories ();
                paned.pack1 (categories, false, false);
                var stack = new Gtk.Stack ();
                paned.add2 (stack);
                categories.set_stack (stack);

                paned.show_all ();
            }

            return paned;
        }

        public override void shown () {

        }

        public override void hidden () {

        }

        public override void search_callback (string location) {
            switch (location) {
                default:
                case "General":
                    categories.set_row_number (0);
                    break;
                case "Audio":
                    categories.set_row_number (2);
                    break;
                case "Typing":
                    categories.set_row_number (3);
                    break;
                case "Keyboard":
                    categories.set_row_number (4);
                    break;
                case "Pointing":
                    categories.set_row_number (5);
                    break;
                case "Clicking":
                    categories.set_row_number (6);
                    break;
            }
        }

        // 'search' returns results like ("Keyboard → Behavior → Duration", "keyboard<sep>behavior")
        public override async Gee.TreeMap<string, string> search (string search) {
            var search_results = new Gee.TreeMap<string, string> ((GLib.CompareDataFunc<string>)strcmp, (Gee.EqualDataFunc<string>)str_equal);
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Features")), "");
            search_results.set ("%s → %s".printf (display_name, _("Audio")), "Audio");
            search_results.set ("%s → %s".printf (display_name, _("Hearing")), "Audio");
            search_results.set ("%s → %s → %s".printf (display_name, _("Audio"), _("Visual Alerts")), "Audio");
            search_results.set ("%s → %s → %s".printf (display_name, _("Audio"), _("Flash screen")), "Audio");
            search_results.set ("%s → %s → %s".printf (display_name, _("Audio"), _("Screen Reader")), "Audio");
            search_results.set ("%s → %s → %s".printf (display_name, _("Audio"), _("Audio descriptions")), "Audio");
            search_results.set ("%s → %s → %s".printf (display_name, _("Audio"), _("keyboard shortcut")), "Audio");
            search_results.set ("%s → %s".printf (display_name, _("Typing")), "Typing");
            search_results.set ("%s → %s → %s".printf (display_name, _("Typing"), _("On-screen keyboard")), "Typing");
            search_results.set ("%s → %s → %s".printf (display_name, _("Typing"), _("Typing Delays")), "Typing");
            search_results.set ("%s → %s → %s".printf (display_name, _("Typing"), _("Delay between key presses (slow keys)")), "Typing");
            search_results.set ("%s → %s → %s".printf (display_name, _("Typing"), _("Beep when a key is pressed")), "Typing");
            search_results.set ("%s → %s → %s".printf (display_name, _("Typing"), _("Beep when a key is accepted")), "Typing");
            search_results.set ("%s → %s → %s".printf (display_name, _("Typing"), _("Beep when a key is rejected")), "Typing");
            search_results.set ("%s → %s → %s".printf (display_name, _("Typing"), _("Typing Delay length")), "Typing");
            search_results.set ("%s → %s → %s".printf (display_name, _("Typing"), _("Fast Typing")), "Typing");
            search_results.set ("%s → %s → %s".printf (display_name, _("Typing"), _("Ignore fast duplicate keypresses (bounce keys)")), "Typing");
            search_results.set ("%s → %s → %s".printf (display_name, _("Typing"), _("Beep when a key is rejected")), "Typing");
            search_results.set ("%s → %s → %s".printf (display_name, _("Typing"), _("Fast Typing Delay length")), "Typing");
            search_results.set ("%s → %s".printf (display_name, _("Keyboard")), "Keyboard");
            search_results.set ("%s → %s → %s".printf (display_name, _("Keyboard"), _("Beep when a lock key is pressed")), "Keyboard");
            search_results.set ("%s → %s → %s".printf (display_name, _("Keyboard"), _("Use modifier keys in sequence (sticky keys)")), "Keyboard");
            search_results.set ("%s → %s → %s".printf (display_name, _("Keyboard"), _("Beep when a modifier key is pressed")), "Keyboard");
            search_results.set ("%s → %s".printf (display_name, _("Clicking")), "Clicking");
            search_results.set ("%s → %s → %s".printf (display_name, _("Clicking"), _("Double-click speed")), "Clicking");
            search_results.set ("%s → %s → %s".printf (display_name, _("Clicking"), _("Hold primary button to trigger secondary click")), "Clicking");
            search_results.set ("%s → %s → %s".printf (display_name, _("Clicking"), _("Simulated secondary click delay")), "Clicking");
            search_results.set ("%s → %s → %s".printf (display_name, _("Clicking"), _("Click when the cursor hovers")), "Clicking");
            search_results.set ("%s → %s → %s".printf (display_name, _("Clicking"), _("Hover click delay")), "Clicking");
            search_results.set ("%s → %s → %s".printf (display_name, _("Clicking"), _("Motion threshold")), "Clicking");
            return search_results;
        }
    }
}

public Switchboard.Plug get_plug (Module module) {
    debug ("Activating Accessibility plug");
    var plug = new Accessibility.Plug ();
    return plug;
}
