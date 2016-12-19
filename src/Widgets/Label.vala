public class Accessibility.Widgets.Label : Gtk.Label {
    public Label (string text) {
        label = text;
        get_style_context ().add_class ("h4");
        halign = Gtk.Align.START;
        hexpand = true;
    }
}

public class Accessibility.Widgets.LinkLabel : Gtk.LinkButton {
    public LinkLabel (string text, string _uri) {
        label = text;
        halign = Gtk.Align.END;
        valign = Gtk.Align.END;
        hexpand = true;
        uri = _uri;
    }
}
