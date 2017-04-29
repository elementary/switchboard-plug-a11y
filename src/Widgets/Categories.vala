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

public class Accessibility.Categories : Gtk.ScrolledWindow {
    private Gtk.Stack stack;
    private Gtk.ListBox list_box;

    construct {
        hscrollbar_policy = Gtk.PolicyType.NEVER;
        set_size_request (176, 10);

        var general = new Panes.General ();
        var display = new Panes.Display ();
        var audio = new Panes.Audio ();
        var typing = new Panes.Typing ();
        var keyboard = new Panes.Keyboard ();
        var pointing = new Panes.Pointing ();
        var clicking = new Panes.Clicking ();

        list_box = new Gtk.ListBox ();
        list_box.expand = true;
        list_box.add (general);
        list_box.add (display);
        list_box.add (audio);
        list_box.add (typing);
        list_box.add (keyboard);
        list_box.add (pointing);
        list_box.add (clicking);

        add (list_box);

        list_box.set_header_func ((row, before) => {
            if (row == display) {
                row.set_header (new Header (_("Seeing")));
            } else if (row == audio) {
                row.set_header (new Header (_("Hearing")));
            } else if (row == typing) {
                row.set_header (new Header (_("Interaction")));
            }
        });

        list_box.row_selected.connect ((row) => {
            var page = ((Pane) row);
            if (page.added == false) {
                page.added = true;
                stack.add (page.pane);
            }

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
        public Gtk.Grid grid { public get; private set; }
        public string icon_name { get; construct; }
        public string label_string { get; construct; }

        public Pane (string label_string, string icon_name) {
            Object (label_string: label_string, icon_name: icon_name);
        }

        construct {
            grid = new Gtk.Grid ();
            grid.orientation = Gtk.Orientation.VERTICAL;
            grid.margin = 12;
            grid.margin_top = 24;
            grid.row_spacing = 12;
            grid.column_spacing = 0;
            grid.expand = true;
            grid.show ();

            pane = new Gtk.ScrolledWindow (null, null);
            pane.add (grid);
            pane.show ();

            var label = new Gtk.Label (label_string);
            label.hexpand = true;
            label.halign = Gtk.Align.START;

            var image = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.DND);

            var rowgrid = new Gtk.Grid ();
            rowgrid.orientation = Gtk.Orientation.HORIZONTAL;
            rowgrid.column_spacing = 6;
            rowgrid.margin = 3;
            rowgrid.margin_start = 12;
            rowgrid.add (image);
            rowgrid.add (label);
            add (rowgrid);
        }
    }

    public class Header : Gtk.Label {
        public Header (string header) {
            label = "%s".printf (GLib.Markup.escape_text (header));
            show_all ();
        }

        construct {
            halign = Gtk.Align.START;
            get_style_context ().add_class ("h4");
        }
    }
}
