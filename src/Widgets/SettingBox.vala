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

public class Accessibility.Widgets.SettingsBox : Gtk.Frame {
    private Gtk.ListBox list_box;
    private bool has_childen = false;

    construct {
        list_box = new Gtk.ListBox ();

        child = list_box;
    }

    public void add_widget (string title, Gtk.Widget widget) {
        has_childen = true;
        widget.margin_end = 6;

        var settings_box = new EmptyBox (title, has_childen);
        settings_box.box.append (widget);
        bind_sensitivity (widget, settings_box);

        list_box.append (settings_box);
    }

    public Gtk.Scale add_scale (string title, Gtk.Adjustment adjustment) {
        var scale = new Gtk.Scale (Gtk.Orientation.HORIZONTAL, adjustment);
        scale.margin_end = 6;
        scale.width_request = 250;
        scale.draw_value = false;

        var settings_box = new EmptyBox (title, has_childen);
        settings_box.box.append (scale);
        bind_sensitivity (scale, settings_box);

        list_box.append (settings_box);

        has_childen = true;
        return scale;
    }

    public Gtk.Switch add_switch (string title) {
        var toggle = new Gtk.Switch ();
        toggle.margin_end = 6;

        var settings_box = new EmptyBox (title, has_childen);
        settings_box.box.append (toggle);
        bind_sensitivity (toggle, settings_box);

        list_box.append (settings_box);

        has_childen = true;
        return toggle;
    }

    private void bind_sensitivity (Gtk.Widget widget, EmptyBox settings_box) {
        widget.bind_property ("sensitive", settings_box, "sensitive", BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL);
    }

    public class EmptyBox : Gtk.ListBoxRow {
        public Gtk.Box box;
        public Gtk.Label label;

        public EmptyBox (string title, bool add_separator) {
            activatable = false;
            selectable = false;

            label = new Gtk.Label (title) {
                margin_top = 8,
                margin_end = 8,
                margin_bottom = 8,
                margin_start = 8
            };
            label.hexpand = true;
            label.halign = Gtk.Align.START;

            box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0) {
                hexpand = true,
                halign = Gtk.Align.END,
                margin_end = 4,
                margin_top = 8,
                margin_bottom = 8
            }
;

            var main_grid = new Gtk.Grid ();
            main_grid.attach (label, 0, 1);
            main_grid.attach (box, 1, 1);

            child = main_grid;

            if (add_separator) {
                var separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
                main_grid.attach (separator, 0, 0, 2, 1);
            }
        }
    }
}
