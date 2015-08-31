public class Accessibility.Widgets.Label : Gtk.Label {

	public Label (string text) {
		label = text;
		get_style_context ().add_class ("h4");
		halign = Gtk.Align.START;
		hexpand = true;
	}
}

public class Accessibility.Widgets.LinkLabel : Gtk.LinkButton {

	public LinkLabel (string text, string command) {
		label = text;
		halign = Gtk.Align.END;
		valign = Gtk.Align.END;
		hexpand = true;
		can_focus = false;

		this.activate_link.connect (() => {
			var cmd = new Granite.Services.SimpleCommand ("/usr/bin", command);
			cmd.run ();
			stderr.printf ("Link clicked \n");
			return true;
		});
	}
}
