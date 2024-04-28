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

from libqtile.dgroups import simple_key_binder
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from qtile_extras import widget as extra_widgets

mod = "mod4"
terminal = "kitty"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),
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
    # Key([mod], "r", lazy.spawn(), desc="Spawn a command using a prompt widget"),
    # Key([mod], "r", lazy.spawn("wofi --show drun,run"), desc="Spawn a command using a prompt widget"),
    Key([mod], "r", lazy.spawn("rofi -show combi -combi-modi \"window,drun,ssh,run\" -modes combi"),
        desc="Spawn a command using a prompt widget"),
    Key([mod, "shift"], "r",
        lazy.restart(),
        desc='Restart Qtile'
        ),
    Key([mod], "b", lazy.hide_show_bar(), desc="Toggle showing the bar"),
    # Quick launch common apps
    Key([mod, "control"], "b", lazy.spawn("brave-browser")),
    Key([mod, "control"], "s", lazy.spawn("steam")),
    Key([mod, "control"], "d", lazy.spawn("discord")),
]

# groups = [Group(i) for i in "123456789"]

groups = [Group("DEV", layout="monadtall"),
          Group("WWW", layout="monadtall",
                matches=[Match(re.compile(r"^(brave-browser)$"))]),
          Group("CHAT", layout="monadtall", spawn="discord",
                matches=[Match(wm_class="Discord")]),
          Group("GAME", layout="max", spawn="steam",
                matches=[Match(wm_class="Steam")]),
          Group("SYS", layout="monadtall"),
          Group("DOC", layout="monadtall"),
          Group("MUS", layout="monadtall")]

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
    layout.Max(),
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
    # layout.Zoomy(),
]


colours = [["#2E383C", "#2E383C"],
           ["#282828", "#282828"],
           ["#D3C6AA", "#D3C6AA"],
           ["#83C092", "#83C092"],
           ["#A7C080", "#A7C080"],
           ["#DBBC7F", "#DBBC7F"],
           ["#7FBBB3", "#7FBBB3"],
           ["#D699B6", "#D699B6"],
           ["#E69875", "#E69875"],
           ["#E67E80", "#E67E80"]]
colour_trans_black = ["#00000000", "#00000000", "#00000000"]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
    background=colours[0]
)
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    widgets_list = [
        widget.Sep(
            linewidth=0,
            padding=6,
            foreground=colours[2],
            background=colours[0]
        ),
        widget.OpenWeather(
            app_key="bdd7a522ba396eefafcc7934577d3fd8",
            background=colours[0],
            location="perth,AU"
        ),
        widget.Spacer(
            background=colour_trans_black,
            length=bar.STRETCH),
        widget.CurrentLayoutIcon(foreground=colours[2],
                                 background=colours[0],
                                 padding=5),
        widget.GroupBox(
            fontsize=9,
            margin_y=3,
            margin_x=0,
            padding_y=5,
            padding_x=3,
            borderwidth=3,
            active=colours[2],
            inactive=colours[7],
            rounded=False,
            highlight_color=colours[1],
            highlight_method="line",
            this_current_screen_border=colours[6],
            this_screen_border=colours[4],
            other_current_screen_border=colours[6],
            other_screen_border=colours[4],
            foreground=colours[2],
            background=colours[0]
        ),
        # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
        # widget.StatusNotifier(
        #   background=colours[0]),
        widget.Spacer(
            background=colour_trans_black,
            length=bar.STRETCH),
        widget.Systray(
            background=colours[0]),
        widget.Sep(
            linewidth=0,
            padding=6,
            foreground=colours[2],
            background=colours[0]
        ),
        widget.Memory(foreground=colours[6]),
        widget.Sep(
            linewidth=0,
            padding=6,
            foreground=colours[2],
            background=colours[0]
        ),
        extra_widgets.PulseVolume(foreground=colours[4]),
        widget.Clock(
            foreground=colours[6],
            background=colours[0],
            format="%Y-%m-%d %a %I:%M %p"
        )
    ]
    return widgets_list


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    # del widgets_screen1[9:10]               # Slicing removes unwanted widgets (systray) on Monitors 1,3
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    del widgets_screen2[6:8]
    return widgets_screen2


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(),
                               margin=[6, 6, 2, 6],
                               background=colour_trans_black,
                               size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(),
                               margin=[6, 6, 2, 6],
                               background=colour_trans_black,
                               size=20))]


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

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


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])


# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
