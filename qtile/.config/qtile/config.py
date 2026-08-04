# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess

from colours import everforest  # custom theming
import libqtile.resources
from libqtile.dgroups import simple_key_binder
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from qtile_extras.widget.decorations import RectDecoration
import qtile_extras.widget as extrawidgets
from libqtile.lazy import lazy

mod = "mod4"
terminal = "kitty"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key(["mod1"], "h", lazy.layout.left(), desc="Move focus to left"),
    Key(["mod1"], "l", lazy.layout.right(), desc="Move focus to right"),
    Key(["mod1"], "j", lazy.layout.down(), desc="Move focus down"),
    Key(["mod1"], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    # Monadtall grow and shrink main
    Key([mod, "mod1"], "h", lazy.layout.grow(),
        desc="MonadTall grow main window"),
    Key([mod, "mod1"], "l", lazy.layout.shrink(),
        desc="MonadTall shrink main window"),
    Key([mod, "mod1"], "o", lazy.layout.maximize(),
        desc="MonadTall maximize window"),
    Key([mod, "mod1"], "n", lazy.layout.normalize(),
        desc="MonadTall normalize window"),
    Key([mod], "n", lazy.next_screen(), desc="Focus next monitor"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "t", lazy.window.toggle_floating()),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.spawn("vicinae toggle"),
        desc="Spawn a command using a prompt widget"),
    Key([mod, "shift"], "r", lazy.restart(), desc='Restart Qtile'),
    Key([mod], "b", lazy.hide_show_bar(), desc="Toggle showing the bar"),
    # Quick launch common apps
    Key([mod, "control"], "b", lazy.spawn("xdg-open")),
    Key([mod, "control"], "s", lazy.spawn("steam")),
    Key([mod, "control"], "d", lazy.spawn("discord")),
    Key([mod, "shift"], "s", lazy.spawn("flameshot gui")),
    # Lock keybind, without or with `xautolock`
    Key([mod], "l", lazy.spawn("xautolock -locknow")),
    Key([mod, "mod1", "shift"], "l", lazy.spawn(
        "/home/danielbrown/.local/scripts/lp-sleep-toggle disable", shell=True)),
    Key([mod, "control", "shift"], "l", lazy.spawn(
        "/home/danielbrown/.local/scripts/lp-sleep-toggle enable", shell=True)),
    # Keybinds for things like monitor brightness and media playback controls
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 2%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 2%+")),
    Key([], "XF86AudioMute", lazy.spawn("amixer sset Master 1+ toggle")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    # Key([], "XF86MonBrightnessUp"
    #     lazy.widget['backlight'].change_backlight(
    #         backlight.ChangeDirection.UP)
    #     ),
    # Key([], "XF86MonBrightnessDown",
    #     lazy.widget['backlight'].change_backlight(
    #         backlight.ChangeDirection.DOWN)
    #     )
    Key([mod], "s", lazy.group["scratchpad"].dropdown_toggle("term")),
]

groups = [Group("DEV", layout="monadtall"),
          Group("WWW", layout="monadtall"),
          Group("MUS", layout="monadtall"),
          Group("PRES", layout="max"),
          Group("SYS", layout="monadtall"),
          Group("DOC", layout="monadtall"),
          ScratchPad("scratchpad", [
              DropDown("term", "kitty --hold", opacity=0.8),
              DropDown("volume", "pavucontrol",
                       x=0.6785, width=0.32, height=0.6, opacity=1,
                       on_focus_lost_hide=True),
              DropDown('calendar', "kitty ikhal",
                       x=0.6785, width=0.32, height=0.997, opacity=1),
              DropDown('process_mem', "kitty sh -c 'HTOPRC=~/.config/htop/mem-htoprc htop --readonly'",
                       x=0.02, width=0.32, height=0.6, opacity=1),
              DropDown('process_cpu', "kitty sh -c 'HTOPRC=~/.config/htop/cpu-htoprc htop --readonly'",
                       x=0.02, width=0.32, height=0.6, opacity=1),
          ]),
          ]

# Allow MODKEY+[0 through 9] to bind to groups, see
# https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
dgroups_key_binder = simple_key_binder(mod)

layout_theme = {
    "border_width": 2,
    "margin": 8,
    "border_focus": "#A7C080",
    "borders_normal": "#374145"
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Columns(**layout_theme),
    layout.Floating(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    layout.Zoomy(**layout_theme),
]

theme = everforest
colour_trans_black = ["#00000000", "#00000000", "#00000000"]

widget_defaults = dict(
    font="MesloLGS NF",
    fontsize=16,
    padding=7,
)
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    decoration_group = {
        "decorations": [
            RectDecoration(
                colour=theme["background"],
                radius=5,
                group=True,
                filled=True,
            )
        ],
        "padding": 6,
    }

    widgets_list = [
        extrawidgets.DoNotDisturb(
            foreground=theme["foreground"],
            **decoration_group
        ),
        extrawidgets.OpenWeather(
            app_key="bdd7a522ba396eefafcc7934577d3fd8",
            cityid="2063523",
            location="perth,AU",
            foreground=theme["foreground"],
            **decoration_group
        ),
        extrawidgets.Memory(
            foreground=theme["green"],
            format="{MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}",
            measure_mem="G",
            update_interval=2.0,
            **decoration_group,
            mouse_callbacks={
                "Button3": lazy.group["scratchpad"].dropdown_toggle("process_mem")
            }
        ),
        extrawidgets.CPU(
            foreground=theme["blue"],
            format="{freq_current}GHz {load_percent}%",
            update_interval=2.0,
            **decoration_group,
            mouse_callbacks={
                "Button3": lazy.group["scratchpad"].dropdown_toggle("process_cpu")
            }
        ),
        widget.Spacer(background=colour_trans_black),
        extrawidgets.CurrentLayout(
            foreground=theme["foreground"],
            **decoration_group
        ),
        extrawidgets.GroupBox(
            fontsize=13,
            margin_y=5,
            margin_x=0,
            borderwidth=3,
            active=theme["foreground"],
            inactive=theme["purple"],
            rounded=True,
            disable_drag=True,
            highlight_color=theme["black"],
            highlight_method="line",
            this_current_screen_border=theme["blue"],
            this_screen_border=theme["green"],
            other_current_screen_border=theme["blue"],
            other_screen_border=theme["green"],
            foreground=theme["foreground"],
            **decoration_group
        ),
        widget.Spacer(background=colour_trans_black),
        # widget.Systray(
        #     **decoration_group
        # ),
        extrawidgets.StatusNotifier(
            **decoration_group
        ),
        extrawidgets.PulseVolume(
            foreground=theme["green"],
            **decoration_group,
            mouse_callbacks={
                "Button3": lazy.group["scratchpad"].dropdown_toggle("volume")
            }),
        extrawidgets.BrightnessControl(
            bar_colour=theme["foreground"],
            error_colour=theme["red"],
            **decoration_group
        ),
        extrawidgets.Clock(
            foreground=theme["blue"],
            format="%a %d %b %H:%M:%S",
            mouse_callbacks={
                "Button3": lazy.group["scratchpad"].dropdown_toggle("calendar")
            },
            **decoration_group,
        ),
        extrawidgets.WiFiIcon(
            foreground=theme["foreground"],
            disconnected_colour=theme["red"],
            active_colour=theme["green"],
            internet_check_timeout=10,
            update_interval=2,
            interface="wlp44s0",
            **decoration_group
        ),
        extrawidgets.BatteryIcon(
            **decoration_group
        )
        # extrawidgets.Battery(
        #     charging_foreground=theme["green"],
        #     foreground=theme["foreground"],
        #     low_percentage=0.2,
        #     low_foreground=theme["red"],
        #     notify_below=20,
        #     **decoration_group,
        #     mouse_callbacks={
        #         "Button2": lazy.widget["battery"].charge_dynamically(),
        #         "Button3": lazy.widget["battery"].charge_to_full()
        #     },
        # ),
    ]
    return widgets_list


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_list(),
                               margin=[6, 6, 2, 6],
                               background=colour_trans_black,
                               size=28,
                               opacity=0)),
            Screen(top=bar.Bar(widgets=init_widgets_list(),
                               margin=[6, 6, 2, 6],
                               background=colour_trans_black,
                               size=28)),
            Screen(top=bar.Bar(widgets=init_widgets_list(),
                               margin=[6, 6, 2, 6],
                               background=colour_trans_black,
                               size=28))]


if __name__ in ["config", "__main__"]:
    screens = init_screens()

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False


# Set group layout to max if on a screen smaller than a certain width
# usually my current laptop screen size
@hook.subscribe.setgroup
def layout_change():
    for screen in qtile.screens:
        if screen.group.name == "PRES":
            continue
        if screen.width <= 1920:
            screen.group.setlayout("max")
        else:
            screen.group.setlayout("monadtall")


# @hook.subscribe.startup_once
# def start_once():
#     home = os.path.expanduser("~")
#     subprocess.call([home + "/.config/qtile/autostart.sh"])


# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
