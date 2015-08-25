public class Accessibility.Widgets.Label : Gtk.Label {
	
	public Label (string text) {
		label = text;
		get_style_context ().add_class ("h4");
		halign = Gtk.Align.START;
		hexpand = true;
	}
}
