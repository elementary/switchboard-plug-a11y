// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*
* Copyright (c) 2015-2016 elementary LLC. (https://launchpad.net/switchboardswitchboard-plug-a11y)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 3 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor,
* Boston, MA 02110-1301, USA.
*
* Authored by: Corentin Noël <corentin@elementary.io>
*/

public class Accessibility.Categories : Gtk.Box {
    private Gtk.Stack stack;
    private Gtk.ListBox list_box;

    construct {
        var audio = new Panes.Audio ();
        var typing = new Panes.Typing ();
        var keyboard = new Panes.Keyboard ();

        list_box = new Gtk.ListBox () {
            width_request = 200,
            vexpand = true
        };

        list_box.append (audio);
        list_box.append (typing);
        list_box.append (keyboard);

        var scrolled = new Gtk.ScrolledWindow () {
            hscrollbar_policy = Gtk.PolicyType.NEVER,
            child = list_box
        };

        append (scrolled);

        list_box.set_header_func ((row, before) => {
            if (row == audio) {
                row.set_header (new Granite.HeaderLabel (_("Hearing")));
            } else if (row == typing) {
                row.set_header (new Granite.HeaderLabel (_("Interaction")));
            }
        });

        list_box.row_selected.connect ((row) => {
            var page = row as Pane;
            if (page == null) {
                return;
            }

            if (page.added == false) {
                page.added = true;
                stack.add_child (page.pane);
            }

            var leaflet = (Adw.Leaflet) get_ancestor (typeof (Adw.Leaflet));
            leaflet.visible_child = stack;

            stack.set_visible_child (page.pane);
        });
    }

    public void set_stack (Gtk.Stack stack) {
        this.stack = stack;
        weak Gtk.ListBoxRow first = list_box.get_row_at_index (0);
        list_box.select_row (first);
        first.activate ();
    }

    public void set_row_number (int number) {
        weak Gtk.ListBoxRow show_row = list_box.get_row_at_index (number);
        list_box.select_row (show_row);
        show_row.activate ();
    }

    public class Pane : Gtk.ListBoxRow {
        public bool added = false;
        public Gtk.ScrolledWindow pane { public get; private set; }
        public string icon_name { get; construct; }
        public string label_string { get; construct; }

        protected Gtk.Box box;

        public Pane (string label_string, string icon_name) {
            Object (label_string: label_string, icon_name: icon_name);
        }

        construct {
            box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12) {
                margin_top = 24,
                margin_end = 12,
                margin_bottom = 12,
                margin_start = 12,
                hexpand = true,
                vexpand = true
            };

            pane = new Gtk.ScrolledWindow () {
                hscrollbar_policy = Gtk.PolicyType.NEVER,
                child = box
            };

            var label = new Gtk.Label (label_string);
            label.hexpand = true;
            label.halign = Gtk.Align.START;

            var image = new Gtk.Image.from_icon_name (icon_name) {
                pixel_size = 32
            };

            var row_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6) {
                margin_top = 3,
                margin_end = 3,
                margin_bottom = 3,
                margin_start = 12
            };
            row_box.append (image);
            row_box.append (label);

            child = row_box;
        }
    }
}
