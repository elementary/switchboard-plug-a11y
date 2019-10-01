/*
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
 * Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor,
 * Boston, MA 02110-1301, USA. Actualy, if you have windows just use
 *
 * Authored by: Felipe Escoto <felescoto95@hotmail.com>
 */

public class Accessibility.Backend.Keyboard : Granite.Services.Settings {
    public bool enable { get; set; }
    public bool slowkeys_enable { get; set; }
    public bool slowkeys_beep_press { get; set; }
    public bool slowkeys_beep_accept { get; set; }
    public bool slowkeys_beep_reject { get; set; }
    public int slowkeys_delay { get; set; }
    public bool bouncekeys_enable { get; set; }
    public bool bouncekeys_beep_reject { get; set; }
    public int bouncekeys_delay { get; set; }
    public bool togglekeys_enable { get; set; }
    public bool stickykeys_enable { get; set; }
    public bool stickykeys_modifier_beep { get; set; }

    public Keyboard () {
        base ("org.gnome.desktop.a11y.keyboard");
    }
}

public class Accessibility.Backend.MediaKeys : Granite.Services.Settings {
    public string screenreader { get; set; }

    public MediaKeys () {
        base ("org.gnome.settings-daemon.plugins.media-keys");

    }
    public string clean_screenreader () {
        var builder = new StringBuilder ();
        if (screenreader.contains ("Alt")) builder.append (("Alt+"));
        if (screenreader.contains ("Shift")) builder.append (("Shift+"));
        if (screenreader.contains ("Super")) builder.append (("Super+"));
        if (screenreader.contains ("Primary")) builder.append (("Ctrl+"));

        var clean = screenreader.replace ("<", "");
        clean = clean.replace (">", "");
        clean = clean.replace ("Alt", "");
        clean = clean.replace ("Shift", "");
        clean = clean.replace ("Super", "");
        clean = clean.replace ("Primary", "");
        builder.append (clean.up ());

        return builder.str;
    }
}

public class Accessibility.Backend.A11y : Granite.Services.Settings {
    public bool always_show_universal_access_status { get; set; }

    public A11y () {
        base ("org.gnome.desktop.a11y");
    }
}

public class Accessibility.Backend.Magnifier : Granite.Services.Settings {
    public bool invert_lightness { get; set; }
    public double color_saturation { get; set; }
    public double contrast_blue { get; set; }
    public double contrast_green { get; set; }
    public double contrast_red { get; set; }
    public bool show_cross_hairs { get; set; }
    public string cross_hairs_color { get; set; }
    public int cross_hairs_thickness { get; set; }
    public string screen_position { get; set; }
    public bool scroll_at_edges { get; set; }
    public bool lens_mode { get; set; }
    public string mouse_tracking { get; set; }
    public double mag_factor { get; set; }

    public Magnifier () {
        base ("org.gnome.desktop.a11y.magnifier");
    }

    public void set_crosshairs_color (Gdk.RGBA rgba) {
        string[] colors = rgba.to_string ().split (",", 3);

        string color_string = "#%2x%2x%2x".printf (
            int.parse (colors[0].replace ("rgb(", "")),
            int.parse (colors[1]),
            int.parse (colors[2].replace (")", ""))
        );

        cross_hairs_color = color_string.replace (" ", "0").up ();
    }

    public Gdk.RGBA get_crosshairs_color () {
        var color = Gdk.RGBA ();
        color.parse (cross_hairs_color);

        return color;
    }

    public int get_position () {
        switch (screen_position) {
            case "full-screen": return 0;
            case "top-half": return 1;
            case "bottom-half": return 2;
            case "left-half": return 3;
            case "right-half": return 4;
        }
        return 0;
    }

    public void set_position (int option) {
        switch (option) {
            case 0:
                screen_position = "full-screen";
                break;
            case 1:
                screen_position = "top-half";
                break;
            case 2:
                screen_position = "bottom-half";
                break;
            case 3:
                screen_position = "left-half";
                break;
            case 4:
                screen_position = "right-half";
                break;
        }
    }

    public int get_tracking () {
        switch (mouse_tracking) {
            case "centered": return 0;
            case "push": return 1;
        }
        return 0;
    }

    public void set_tracking (int option) {
        switch (option) {
            case 0:
                mouse_tracking = "centered";
                break;
            case 1:
                mouse_tracking = "push";
                break;
        }
    }
}

public class Accessibility.Backend.Applications : Granite.Services.Settings {
    public bool screen_magnifier_enabled { get; set; }
    public bool screen_reader_enabled { get; set; }
    public bool screen_keyboard_enabled { get; set; }

    public Applications () {
        base ("org.gnome.desktop.a11y.applications");
    }
}

public class Accessibility.Backend.WmPreferences : Granite.Services.Settings {
    public bool visual_bell { get; set; }
    public string? theme { get; set; }

    public WmPreferences () {
        base ("org.gnome.desktop.wm.preferences");
    }
}

public class Accessibility.Backend.Peripherals : Granite.Services.Settings {
    public int double_click { get; set; }

    public Peripherals () {
        base ("org.gnome.settings-daemon.peripherals.mouse");
    }
}

public class Accessibility.Backend.Mouse : Granite.Services.Settings {
    public bool secondary_click_enabled { get; set; }
    public double secondary_click_time { get; set; }
    public bool dwell_click_enabled { get; set; }
    public double dwell_time { get; set; }
    public int dwell_threshold { get; set; }

    public Mouse () {
        base ("org.gnome.desktop.a11y.mouse");
    }
}
