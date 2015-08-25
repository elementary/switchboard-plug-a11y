
public class Accessibility.Widgets.EmptyBox : Gtk.ListBoxRow {

    public Gtk.Grid grid;
    public Gtk.Label label;

    public EmptyBox (string title) {
	    set_activatable (false);
	    set_selectable (false);
	    margin = 8;
        set_margin_end (4);
		var main_grid = new Gtk.Grid ();

		label = new Gtk.Label (title);
        label.hexpand = true;
        label.halign = Gtk.Align.START;

        grid = new Gtk.Grid ();
        grid.hexpand = true;
        grid.halign = Gtk.Align.END;

        main_grid.attach (label, 0, 0, 1, 1);
        main_grid.attach (grid, 1, 0, 1, 1);
        add (main_grid);

        show_all ();
    }

}

public class Accessibility.Widgets.SettingsBox : Gtk.Frame {
    Gtk.ListBox list_box;

	public SettingsBox () {
		list_box = new Gtk.ListBox ();
		this.add (list_box);
	}

	public void add_widget (string title, Gtk.Widget widget) {
	    var settings_box = new Accessibility.Widgets.EmptyBox (title);
        widget.set_margin_end (12);

 		settings_box.grid.add (widget);
        list_box.add (settings_box);
        show_all ();
	}

	public Gtk.ComboBox add_combo_box (string title) {
	    var settings_box = new Accessibility.Widgets.EmptyBox (title);
        var combo = new Gtk.ComboBox ();
        combo.set_size_request (180,0);
        combo.set_margin_end (12);
        
	    settings_box.grid.add (combo);
        list_box.add (settings_box);
        show_all ();

        return combo;
	}

	public Gtk.Scale add_scale (string title, Gtk.Adjustment adjustment) {
		var settings_box = new Accessibility.Widgets.EmptyBox (title);
        var scale = new Gtk.Scale (Gtk.Orientation.HORIZONTAL, adjustment);
        scale.set_size_request (250,0);
        scale.set_draw_value (false);
        scale.set_margin_end (12);

 		settings_box.grid.add (scale);
        list_box.add (settings_box);
        show_all ();

        return scale;
	}

	public Gtk.Switch add_switch (string title) {
	    var settings_box = new Accessibility.Widgets.EmptyBox (title);
        var toggle = new Gtk.Switch ();

	    settings_box.grid.add (toggle);
        list_box.add (settings_box);
        show_all ();

        return toggle;
	}
}

