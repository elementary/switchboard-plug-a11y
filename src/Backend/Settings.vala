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
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * Authored by: Felipe Escoto <felescoto95@hotmail.com>
 */
// TODO: Dyslexic Font,

public class Accessibility.Backend.DesktopInterface : Granite.Services.Settings {
    public string gtk_theme { get; set; }
    public string icon_theme { get; set; }
    public double text_scaling_factor { get; set; }
    public int cursor_size { get; set; }

    public DesktopInterface () {
        base ("org.gnome.desktop.interface");
    }
}

public class Accessibility.Backend.Keyboard : Granite.Services.Settings {
    public bool enable  { get; set; }
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
    public bool mousekeys_enable { get; set; }
    public int mousekeys_max_speed { get; set; }

    public Keyboard () {
        base ("org.gnome.desktop.a11y.keyboard");
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

    public WmPreferences () {
        base ("org.desktop.wm.preferences");
    }
}

public class Accessibility.Backend.Peripherals : Granite.Services.Settings {
    public int double_click { get; set; }

    public Peripherals () {
        base ("org.gnome.settings_deamon.peripherals.mouse");
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
