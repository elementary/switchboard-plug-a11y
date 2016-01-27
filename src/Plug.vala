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
namespace Accessibility {
    public static Plug plug;

    public Accessibility.Backend.DesktopInterface   deskop_interface_settings;
    public Accessibility.Backend.Keyboard           keyboard_settings;
    public Accessibility.Backend.A11y               a11y_settings;
    public Accessibility.Backend.Magnifier          magnifier_settings;
    public Accessibility.Backend.Applications       applications_settings;
    public Accessibility.Backend.WmPreferences      wm_preferences_settings;
    public Accessibility.Backend.Peripherals        peripherals_settings;
    public Accessibility.Backend.Mouse              mouse_settings;
    public Accessibility.Backend.MediaKeys          media_keys_settings;

    public class Plug : Switchboard.Plug {
        Gtk.Paned paned;
        Accessibility.Categories categories;

        public Plug () {
            Object (category: Category.SYSTEM,
                    code_name: Build.PLUGCODENAME,
                    display_name: _("Universal Access"),
                    description: _("Configure accessibility features"),
                    icon: "preferences-desktop-accessibility");

            plug = this;

            deskop_interface_settings = new Accessibility.Backend.DesktopInterface ();
            keyboard_settings =         new Accessibility.Backend.Keyboard ();
            a11y_settings =             new Accessibility.Backend.A11y ();
            magnifier_settings =        new Accessibility.Backend.Magnifier ();
            applications_settings =     new Accessibility.Backend.Applications ();
            wm_preferences_settings =   new Accessibility.Backend.WmPreferences ();
            peripherals_settings =      new Accessibility.Backend.Peripherals ();
            mouse_settings =            new Accessibility.Backend.Mouse ();
            media_keys_settings =       new Accessibility.Backend.MediaKeys ();
        }

        public override Gtk.Widget get_widget () {
            if (paned == null) {
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
                case "Display":
                    categories.set_row_number (1);
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
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Feaures")), "General");
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Display Feaures")), "Display");
            search_results.set ("%s → %s".printf (display_name, _("High Contrast Theme")), "Display");
            search_results.set ("%s → %s".printf (display_name, _("Font Size")), "Display");
            search_results.set ("%s → %s".printf (display_name, _("Text Size")), "Display");
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Audio Feaures")), "Audio");
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Hearing Feaures")), "Audio");
            search_results.set ("%s → %s".printf (display_name, _("Visual Alerts")), "Audio");
            search_results.set ("%s → %s".printf (display_name, _("Screen Reader")), "Audio");
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Keyboard Feaures")), "Keyboard");
            search_results.set ("%s → %s".printf (display_name, _("On Screen Keyboard")), "Typing");
            search_results.set ("%s → %s".printf (display_name, _("Fast Typing")), "Typing");
            search_results.set ("%s → %s".printf (display_name, _("Typing Delay")), "Typing");
            search_results.set ("%s → %s".printf (display_name, _("Keyboard Sounds")), "Typing");
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Mouse Feaures")), "Clicking");
            search_results.set ("%s → %s".printf (display_name, _("Hover Click")), "Clicking");
            search_results.set ("%s → %s".printf (display_name, _("Simulated Secondary Click")), "Clicking");
            return search_results;
        }
    }
}

public Switchboard.Plug get_plug (Module module) {
    debug ("Activating Accessibility plug");
    var plug = new Accessibility.Plug ();
    return plug;
}
