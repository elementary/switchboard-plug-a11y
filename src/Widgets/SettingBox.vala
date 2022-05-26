/*
* Copyright (c) 2015-2020 elementary, Inc (https://elementary.io)
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
*/

public class Accessibility.Widgets.SettingsBox : Gtk.Box {
    private Gtk.ListBox list_box;

    construct {
        list_box = new Gtk.ListBox () {
            hexpand = true,
            show_separators = true
        };
        list_box.add_css_class ("rich-list");
        list_box.add_css_class ("frame");

        append (list_box);
    }

    public void add_widget (string title, Gtk.Widget widget) {
        var settings_box = new EmptyBox (title);
        settings_box.box.append (widget);
        bind_sensitivity (widget, settings_box);

        list_box.append (settings_box);
    }

    public Gtk.Scale add_scale (string title, Gtk.Adjustment adjustment) {
        var scale = new Gtk.Scale (Gtk.Orientation.HORIZONTAL, adjustment);
        scale.width_request = 250;
        scale.draw_value = false;

        var settings_box = new EmptyBox (title);
        settings_box.box.append (scale);
        bind_sensitivity (scale, settings_box);

        list_box.append (settings_box);

        return scale;
    }

    public Gtk.Switch add_switch (string title) {
        var toggle = new Gtk.Switch ();

        var settings_box = new EmptyBox (title);
        settings_box.box.append (toggle);
        bind_sensitivity (toggle, settings_box);

        list_box.append (settings_box);

        return toggle;
    }

    private void bind_sensitivity (Gtk.Widget widget, EmptyBox settings_box) {
        widget.bind_property ("sensitive", settings_box, "sensitive", BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL);
    }

    public class EmptyBox : Gtk.ListBoxRow {
        public Gtk.Box box;
        public Gtk.Label label;

        public EmptyBox (string title) {
            activatable = false;
            selectable = false;

            label = new Gtk.Label (title);
            label.hexpand = true;
            label.halign = Gtk.Align.START;

            box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0) {
                valign = Gtk.Align.CENTER
            };
            box.append (label);

            child = box;
        }
    }
}
