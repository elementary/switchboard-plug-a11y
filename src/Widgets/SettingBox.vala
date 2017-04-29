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
*/

public class Accessibility.Widgets.SettingsBox : Gtk.Frame {
    private Gtk.ListBox list_box;
    private bool has_childen = false;

    construct {
        list_box = new Gtk.ListBox ();
        this.add (list_box);
    }

    public void add_widget (string title, Gtk.Widget widget) {
        has_childen = true;
        widget.margin_end = 6;

        var settings_box = new EmptyBox (title, has_childen);
        settings_box.grid.add (widget);
        bind_sensitivity (widget, settings_box);

        list_box.add (settings_box);
        show_all ();
    }

    public Gtk.ComboBox add_combo_box (string title) {
        var renderer = new Gtk.CellRendererText ();

        var combo = new Gtk.ComboBox ();
        combo.margin_end = 6;
        combo.width_request = 180;
        combo.pack_start (renderer, true);
        combo.add_attribute (renderer, "text", 0);

        var settings_box = new EmptyBox (title, has_childen);
        settings_box.grid.add (combo);
        bind_sensitivity (combo, settings_box);

        list_box.add (settings_box);
        show_all ();

        has_childen = true;
        return combo;
    }

    public Gtk.Scale add_scale (string title, Gtk.Adjustment adjustment) {
        var scale = new Gtk.Scale (Gtk.Orientation.HORIZONTAL, adjustment);
        scale.margin_end = 6;
        scale.width_request = 250;
        scale.draw_value = false;

        var settings_box = new EmptyBox (title, has_childen);
        settings_box.grid.add (scale);
        bind_sensitivity (scale, settings_box);

        list_box.add (settings_box);
        show_all ();

        has_childen = true;
        return scale;
    }

    public Gtk.Switch add_switch (string title) {
        var toggle = new Gtk.Switch ();
        toggle.margin_end = 6;

        var settings_box = new EmptyBox (title, has_childen);
        settings_box.grid.add (toggle);
        bind_sensitivity (toggle, settings_box);

        list_box.add (settings_box);
        show_all ();

        has_childen = true;
        return toggle;
    }

    public void bind_sensitivity (Gtk.Widget widget, EmptyBox settings_box ) {
        widget.bind_property ("sensitive", settings_box, "sensitive", BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL);
    }

    public class EmptyBox : Gtk.ListBoxRow {
        public Gtk.Grid grid;
        public Gtk.Label label;

        public EmptyBox (string title, bool add_separator) {
            activatable = false;
            selectable = false;

            label = new Gtk.Label (title);
            label.hexpand = true;
            label.halign = Gtk.Align.START;
            label.margin = 8;

            grid = new Gtk.Grid ();
            grid.hexpand = true;
            grid.halign = Gtk.Align.END;
            grid.margin_end = 4;
            grid.margin_top = 8;
            grid.margin_bottom = 8;

            var main_grid = new Gtk.Grid ();
            main_grid.attach (label, 0, 1, 1, 1);
            main_grid.attach (grid, 1, 1, 1, 1);
            add (main_grid);

            if (add_separator) {
                var separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
                main_grid.attach (separator, 0, 0, 2, 1);
            }

            show_all ();
        }
    }
}
