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
public class Accessibility.Categories : Gtk.ScrolledWindow {
    private Gtk.Stack stack;
    private Gtk.ListBox list_box;

    public Categories () {
        
    }

    construct {
        hscrollbar_policy = Gtk.PolicyType.NEVER;
        list_box = new Gtk.ListBox ();
        list_box.expand = true;
        add (list_box);

        var general = new Panes.General ();
        list_box.add (general);

        var display = new Panes.Display ();
        list_box.add (display);

        var zoom = new Panes.Zoom ();
        list_box.add (zoom);

        var audio = new Panes.Audio ();
        list_box.add (audio);

        var screenreader = new Panes.ScreenReader ();
        list_box.add (screenreader);

        var typing = new Panes.Typing ();
        list_box.add (typing);

        var keyboard = new Panes.Keyboard ();
        list_box.add (keyboard);

        var pointing = new Panes.Pointing ();
        list_box.add (pointing);

        var clicking = new Panes.Clicking ();
        list_box.add (clicking);

        list_box.set_header_func ((row, before) => {
            if (row == display) {
                row.set_header (new Header (_("Seeing")));
            } else if (row == audio) {
                row.set_header (new Header (_("Hearing")));
            } else if (row == typing) {
                row.set_header (new Header (_("Interaction")));
            }
        });

        list_box.row_activated.connect ((row) => {
            var grid = ((Pane) row).grid;
            if (grid.parent == null) {
                stack.add (grid);
            }

            stack.set_visible_child (grid);
        });
    }

    public void set_stack (Gtk.Stack stack) {
        this.stack = stack;
        weak Gtk.ListBoxRow first = list_box.get_row_at_index (0);
        list_box.select_row (first);
        first.activate ();
    }

    public class Pane : Gtk.ListBoxRow {
        Gtk.Label label;
        Gtk.Image image;
        public Gtk.Grid grid { public get; private set; }
        public Pane (string label_string, string icon_name) {
            label.label = label_string;
            image.icon_name = icon_name;
        }

        construct {
            var rowgrid = new Gtk.Grid ();
            rowgrid.orientation = Gtk.Orientation.HORIZONTAL;
            rowgrid.column_spacing = 6;
            rowgrid.margin = 3;
            rowgrid.margin_start = 12;
            add (rowgrid);

            label = new Gtk.Label (null);
            label.hexpand = true;
            ((Gtk.Misc) label).xalign = 0;

            image = new Gtk.Image ();
            image.icon_size = Gtk.IconSize.DND;

            rowgrid.add (image);
            rowgrid.add (label);

            grid = new Gtk.Grid ();
            grid.margin = 12;
            grid.margin_top = 24;
            grid.row_spacing = 12;
            grid.column_spacing = 6;
            grid.expand = true;
            grid.show ();
        }
    }

    public class Header : Gtk.Label {
        public Header (string header) {
            label = "%s".printf (GLib.Markup.escape_text (header));
            show_all ();
        }

        construct {
            ((Gtk.Misc) this).xalign = 0;
            get_style_context ().add_class ("h4");
        }
    }
}
