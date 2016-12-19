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
* Free Software Foundation, Inc., 59 Temple Place - Suite 330,
* Boston, MA 02111-1307, USA.
*/

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
