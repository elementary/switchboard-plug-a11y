/*
* Copyright (c) 2017 elementary LLC. (https://elementary.io)
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 2.1 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Library General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*/

public class Switchboard.SidebarRow : Gtk.ListBoxRow {
    public string title { get; construct; }

    public SidebarRow (string title) {
        Object (
            title: title
        );
    }

    construct {
        var icon = new Gtk.Image.from_icon_name ("application-default-icon", Gtk.IconSize.DND);
        icon.pixel_size = 32;

        var label = new Gtk.Label (title);
        label.get_style_context ().add_class ("h3");

        var grid = new Gtk.Grid ();
        grid.column_spacing = 12;
        grid.margin = 3;
        grid.margin_start = 6;
        grid.margin_end = 6;
        grid.add (icon);
        grid.add (label);

        add (grid);
    }
}
