/*-
 * Copyright 2015–2021 elementary, Inc (https://elementary.io)
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
    public class Plug : Switchboard.Plug {
        Gtk.Grid grid;
        Accessibility.Categories categories;

        public static GLib.Settings applications_settings;
        public static GLib.Settings keyboard_settings;

        public Plug () {
            var settings = new Gee.TreeMap<string, string?> (null, null);
            settings.set ("universal-access", null);

            Object (category: Category.SYSTEM,
                    code_name: "io.elementary.switchboard.a11y",
                    display_name: _("Universal Access"),
                    description: _("Configure accessibility features"),
                    icon: "preferences-desktop-accessibility",
                    supported_settings: settings);
        }

        static construct {
            applications_settings = new GLib.Settings ("org.gnome.desktop.a11y.applications");
            keyboard_settings = new GLib.Settings ("org.gnome.desktop.a11y.keyboard");
        }

        public override Gtk.Widget get_widget () {
            if (grid == null) {
                var info_title = _("Looking for more settings?");
                var info_details = _("Accessibility features can be found throughout System Settings. Check the relevant settings pages or use the search bar from the All Settings screen.");

                var info_label = new Gtk.Label ("<b>%s</b> %s".printf (info_title, info_details)) {
                    use_markup = true,
                    wrap = true,
                    xalign = 0
                };

                var infobar = new Gtk.InfoBar ();

                // Need to pack_start for proper spacing and margins
                var infobar_box = (Gtk.Box) infobar.get_content_area ();
                infobar_box.pack_start (info_label);

                var stack = new Gtk.Stack ();

                categories = new Categories ();
                categories.set_stack (stack);

                var indicator_label = new Granite.HeaderLabel (_("Show in Panel")) {
                    margin_start = 3
                };

                var indicator_switch = new Gtk.Switch () {
                    margin = 6,
                    margin_end = 3
                };

                var footer = new Gtk.ActionBar ();
                footer.get_style_context ().add_class (Gtk.STYLE_CLASS_INLINE_TOOLBAR);
                footer.pack_start (indicator_label);
                footer.pack_end (indicator_switch);

                var sidebar = new Gtk.Grid ();
                sidebar.attach (categories, 0, 0);
                sidebar.attach (footer, 0, 1);

                var paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
                paned.pack1 (sidebar, false, false);
                paned.add2 (stack);

                grid = new Gtk.Grid () {
                    orientation = Gtk.Orientation.VERTICAL
                };

                grid.add (infobar);
                grid.add (paned);

                grid.show_all ();

                var panel_settings = new Settings ("io.elementary.desktop.wingpanel.a11y");
                panel_settings.bind ("show-indicator", indicator_switch, "active", SettingsBindFlags.DEFAULT);
            }

            return grid;
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
            return search_results;
        }
    }
}

public Switchboard.Plug get_plug (Module module) {
    debug ("Activating Accessibility plug");
    var plug = new Accessibility.Plug ();
    return plug;
}
