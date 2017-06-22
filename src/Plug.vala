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

    public Accessibility.Backend.DesktopInterface   deskop_interface_settings;
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
        private Gtk.Stack stack;

        public Plug () {
            var settings = new Gee.TreeMap<string, string?> (null, null);
            settings.set ("universal-access", null);

            Object (category: Category.SYSTEM,
                    code_name: Build.PLUGCODENAME,
                    display_name: _("Universal Access"),
                    description: _("Configure accessibility features"),
                    icon: "preferences-desktop-accessibility",
                    supported_settings: settings);

            plug = this;

            var animations_schema = "org.pantheon.desktop.gala.animations";

            var animations = SettingsSchemaSource.get_default ().lookup (animations_schema, false);
            if (animations != null) {
                animations_settings = new Settings (animations_schema);
            }

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

                var display = new Panes.Display ();
                var audio = new Panes.Audio ();
                var typing = new Panes.Typing ();
                var keyboard = new Panes.Keyboard ();
                var pointing = new Panes.Pointing ();
                var clicking = new Panes.Clicking ();

                stack = new Gtk.Stack ();
                if (animations_settings != null) {
                    var general = new Panes.General ();
                    stack.add_titled (general, "general", _("General"));
                }
                stack.add_titled (display, "display", _("Display"));
                stack.add_titled (audio, "audio", _("Audio"));
                stack.add_titled (typing, "typing", _("Typing"));
                stack.add_titled (keyboard, "keyboard", _("Keyboard"));
                stack.add_titled (pointing, "pointing", _("Pointing"));
                stack.add_titled (clicking, "clicking", _("Clicking"));

                var categories = new Switchboard.Sidebar (stack);

                paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
                paned.pack1 (categories, false, false);
                paned.add2 (stack);

                paned.show_all ();
            }

            return paned;
        }

        public override void shown () {

        }

        public override void hidden () {

        }

        public override void search_callback (string location) {
            stack.visible_child_name = location;
        }

        // 'search' returns results like ("Keyboard → Behavior → Duration", "keyboard<sep>behavior")
        public override async Gee.TreeMap<string, string> search (string search) {
            var search_results = new Gee.TreeMap<string, string> ((GLib.CompareDataFunc<string>)strcmp, (Gee.EqualDataFunc<string>)str_equal);
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Features")), "general");
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Display Features")), "display");
            search_results.set ("%s → %s".printf (display_name, _("High Contrast Theme")), "display");
            search_results.set ("%s → %s".printf (display_name, _("Font Size")), "display");
            search_results.set ("%s → %s".printf (display_name, _("Text Size")), "display");
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Audio Features")), "audio");
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Hearing Features")), "audio");
            search_results.set ("%s → %s".printf (display_name, _("Visual Alerts")), "audio");
            search_results.set ("%s → %s".printf (display_name, _("Screen Reader")), "audio");
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Keyboard Features")), "keyboard");
            search_results.set ("%s → %s".printf (display_name, _("On Screen Keyboard")), "typing");
            search_results.set ("%s → %s".printf (display_name, _("Fast Typing")), "typing");
            search_results.set ("%s → %s".printf (display_name, _("Typing Delay")), "typing");
            search_results.set ("%s → %s".printf (display_name, _("Keyboard Sounds")), "typing");
            search_results.set ("%s → %s".printf (display_name, _("Accessibility Mouse Features")), "clicking");
            search_results.set ("%s → %s".printf (display_name, _("Hover Click")), "clicking");
            search_results.set ("%s → %s".printf (display_name, _("Simulated Secondary Click")), "clicking");
            return search_results;
        }
    }
}

public Switchboard.Plug get_plug (Module module) {
    debug ("Activating Accessibility plug");
    var plug = new Accessibility.Plug ();
    return plug;
}
