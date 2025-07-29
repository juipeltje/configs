# Qtile config

# Import libraries
from libqtile.lazy import lazy
from libqtile.config import Key, Drag, Group, ScratchPad, DropDown
from libqtile import layout, qtile, hook
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
from libqtile.backend.wayland import InputConfig
import os
import subprocess
import colors

# Variables
home = os.path.expanduser("~")
mod = "mod4"
terminal = "alacritty"
image_terminal = "kitty"
wayland_terminal = "foot"
webbrowser = "librewolf"
hostname = os.uname()[1]


# autostart programs when starting window manager
@hook.subscribe.startup_once
def autostart():
    common_autostart = os.path.expanduser(
        "~/repos/configs/dotfiles/common/dotconfig/qtile/autostart.sh"
    )
    workstation_autostart = os.path.expanduser(
        "~/repos/configs/scripts/autostart/workstation-autostart.sh"
    )
    laptop_autostart = os.path.expanduser(
        "~/repos/configs/scripts/autostart/laptop-autostart.sh"
    )

    if qtile.core.name == "x11":
        if hostname == "Void-Rig":
            processes = [
                # [ 'dbus-update-activation-environment', '--systemd', 'DISPLAY', 'XDG_CURRENT_DESKTOP', 'XDG_SESSION_ID' ],
                # [ 'systemctl', '--user', 'import-environment', 'DISPLAY' ],
                # [ 'systemctl', '--user', 'start', 'qtile-session.target' ]
                [common_autostart],
                [workstation_autostart],
            ]

            for p in processes:
                subprocess.Popen(p)

        elif hostname == "Void-Lappie":
            processes = [
                # [ 'dbus-update-activation-environment', '--systemd', 'DISPLAY', 'XDG_CURRENT_DESKTOP', 'XDG_SESSION_ID' ],
                # [ 'systemctl', '--user', 'import-environment', 'DISPLAY' ],
                # [ 'systemctl', '--user', 'start', 'qtile-session.target' ]
                [common_autostart],
                [laptop_autostart],
            ]

            for p in processes:
                subprocess.Popen(p)

    elif qtile.core.name == "wayland":
        if hostname == "Void-Rig":
            processes = [
                # [ 'dbus-update-activation-environment', '--systemd', 'DISPLAY', 'WAYLAND_DISPLAY', 'XDG_CURRENT_DESKTOP', 'XDG_SESSION_ID' ],
                # [ 'systemctl', '--user', 'import-environment', '{,WAYLAND_}DISPLAY' ],
                # [ 'systemctl', '--user', 'start', 'qtile-wayland-session.target' ]
                [common_autostart],
                [workstation_autostart],
            ]

            for p in processes:
                subprocess.Popen(p)

        elif hostname == "Void-Lappie":
            processes = [
                # [ 'dbus-update-activation-environment', '--systemd', 'DISPLAY', 'WAYLAND_DISPLAY', 'XDG_CURRENT_DESKTOP', 'XDG_SESSION_I>
                # [ 'systemctl', '--user', 'import-environment', '{,WAYLAND_}DISPLAY' ],
                # [ 'systemctl', '--user', 'start', 'qtile-wayland-session.target' ]
                [common_autostart],
                [laptop_autostart],
            ]

            for p in processes:
                subprocess.Popen(p)


# Keybindings
keys = [
    # Open a webbrowser
    Key([mod], "w", lazy.spawn(webbrowser)),
    
    # Open pavucontrol
    Key([mod], "a", lazy.spawn("pavucontrol")),
    
    # open theme switcher
    Key([mod, "shift"], "t", lazy.spawn(home + "/repos/configs/scripts/dmenu/theme-switcher.sh")),
    
    # open powermenu
    Key([mod], "Escape", lazy.spawn(home + "/repos/configs/scripts/dmenu/powermenu.sh")),
    
    # open compositor switcher
    Key([mod, "shift"], "c", lazy.spawn(home + "/repos/configs/scripts/dmenu/compositor-switcher.sh")),
    
    # open LLM launcher
    Key([mod], "l", lazy.spawn(home + "/repos/configs/scripts/dmenu/llm-launcher.sh")),
    
    # play/pause/previous/next keyboard controls
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    
    # Reload config and restart qtile
    Key([mod], "r", lazy.reload_config()),
    Key([mod, "control"], "r", lazy.restart()),
    
    # Kill a window
    Key([mod], "q", lazy.window.kill()),
    
    # Switch focused window
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    
    # Toggle floating window
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
    
    # Toggle fullscreen
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen()),
    
    # Grow windows
    Key([mod, "mod1"], "Right", lazy.layout.grow_right()),
    Key([mod, "mod1"], "Left", lazy.layout.grow_left()),
    Key([mod, "mod1"], "Up", lazy.layout.grow_up()),
    Key([mod, "mod1"], "Down", lazy.layout.grow_down()),
    
    # Move windows between left/right columns or move up/down in current stack
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    
    # Grow/shrink windows in layout and reset
    Key([mod], "KP_Add", lazy.layout.grow()),
    Key([mod], "KP_Subtract", lazy.layout.shrink()),
    Key([mod], "KP_Enter", lazy.layout.reset()),
    
    # Toggle between the different layouts
    Key([mod, "shift"], "l", lazy.next_layout()),
    
    # Go to next/previous group
    Key([mod, "control"], "Right", lazy.screen.next_group()),
    Key([mod, "control"], "Left", lazy.screen.prev_group()),
    
    # Toggle Scratchpad
    Key([mod], "s", lazy.group["0"].dropdown_toggle("term")),
]

if qtile.core.name == "x11":
    keys.extend(
        [
            # Open a terminal
            Key([mod], "t", lazy.spawn(terminal)),
            
            # Open file manager
            Key([mod], "f", lazy.spawn(image_terminal + " -e yazi")),
            
            # open application launcher
            Key([mod], "space", lazy.spawn("rofi -show drun")),
            
            # notification history and close all notifications
            Key([mod], "n", lazy.spawn("dunstctl history-pop")),
            Key([mod], "c", lazy.spawn("dunstctl close-all")),
            
            # Start/stop picom keybindings for playing games
            Key([mod], "g", lazy.spawn(home + "/repos/configs/scripts/start-gamemode.sh")),
            Key([mod], "p", lazy.spawn(home + "/repos/configs/scripts/stop-gamemode.sh")),
        ]
    )

elif qtile.core.name == "wayland":
    keys.extend(
        [
            # Open a terminal
            Key([mod], "t", lazy.spawn(wayland_terminal)),
            
            # Open file manager
            Key([mod], "f", lazy.spawn(wayland_terminal + " -e yazi")),
            
            # open application launcher
            Key([mod], "space", lazy.spawn("fuzzel")),
            
            # notification history and close all notifications
            Key([mod], "n", lazy.spawn("makoctl restore")),
            Key([mod], "c", lazy.spawn("makoctl dismiss --all")),
        ]
    )

mouse = [
    # Dragging and resizing floating windows with mod + mouse buttons
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
]

if qtile.core.name == "x11":
    groups = [
        Group("1", layout="monadtall", label="  1", screen_affinity=0),
        Group("2", layout="monadtall", label="  2", screen_affinity=0),
        Group("3", layout="monadtall", label="  3", screen_affinity=0),
        Group("4", layout="monadtall", label="  4", screen_affinity=0),
        Group("5", layout="monadtall", label="  5", screen_affinity=0),
        Group("6", layout="monadtall", label="  6", screen_affinity=0),
        Group("7", layout="monadtall", label="  7", screen_affinity=0),
        Group("8", layout="monadtall", label="  8", screen_affinity=1),
    ]

    numpad_keys = [
        "KP_End",
        "KP_Down",
        "KP_Next",
        "KP_Left",
        "KP_Begin",
        "KP_Right",
        "KP_Home",
        "KP_Up",
    ]

    for i, numpad_key in zip(groups, numpad_keys):
        keys.extend(
            [
                # mod + number of group = switch to group
                Key([mod], i.name, lazy.group[i.name].toscreen()),
                
                # move window to group
                Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
                
                # switch between groups using the numpad
                Key([mod], numpad_key, lazy.group[i.name].toscreen()),
                
                # move windows to group using the numpad
                Key([mod, "shift"], numpad_key, lazy.window.togroup(i.name)),
            ]
        )

    # Scratchpad window settings
    groups.append(
        ScratchPad(
            "0",
            [
                DropDown(
                    "term",
                    terminal + " --class scratchpad",
                    opacity=1,
                    width=0.4,
                    height=0.6,
                    x=0.3,
                    y=0.2,
                    on_focus_lost_hide=False,
                ),
            ],
        ),
    )

elif qtile.core.name == "wayland":
    groups = [
        Group("1", layout="monadtall", label="  1", screen_affinity=1),
        Group("2", layout="monadtall", label="  2", screen_affinity=1),
        Group("3", layout="monadtall", label="  3", screen_affinity=1),
        Group("4", layout="monadtall", label="  4", screen_affinity=1),
        Group("5", layout="monadtall", label="  5", screen_affinity=1),
        Group("6", layout="monadtall", label="  6", screen_affinity=1),
        Group("7", layout="monadtall", label="  7", screen_affinity=1),
        Group("8", layout="monadtall", label="  8", screen_affinity=0),
    ]

    numpad_keys = [
        "KP_End",
        "KP_Down",
        "KP_Next",
        "KP_Left",
        "KP_Begin",
        "KP_Right",
        "KP_Home",
        "KP_Up",
    ]

    for i, numpad_key in zip(groups, numpad_keys):
        keys.extend(
            [
                # mod + number of group = switch to group
                Key([mod], i.name, lazy.group[i.name].toscreen()),
                
                # move window to group
                Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
                
                # switch between groups using the numpad
                Key([mod], numpad_key, lazy.group[i.name].toscreen()),
                
                # move windows to group using the numpad
                Key([mod, "shift"], numpad_key, lazy.window.togroup(i.name)),
            ]
        )

    # Scratchpad window settings
    groups.append(
        ScratchPad(
            "0",
            [
                DropDown(
                    "term",
                    wayland_terminal + " --app-id scratchpad",
                    opacity=1,
                    width=0.4,
                    height=0.6,
                    x=0.3,
                    y=0.2,
                    on_focus_lost_hide=False,
                ),
            ],
        ),
    )

# set colorscheme
colors = colors.GruvboxDark

layout_theme = {
    "border_focus": colors[0],
    "border_normal": colors[2],
    "border_width": 4,
    "margin": 10,
}


layouts = [
    layout.MonadTall(**layout_theme),
    layout.Spiral(**layout_theme),
    # layout.Tile(**layout_theme),
    # layout.MonadWide(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Max(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Columns(**layout_theme),
    # layout.Floating(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.MonadThreeCol(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Slice(**layout_theme),
    # layout.Stack(**layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.Zoomy(**layout_theme),
]

cursor_warp = True

floating_layout = layout.Floating(**layout_theme)

# wmname = "LG3D"
if qtile.core.name == "x11":
    wmname = "Qtile (X11)"
elif qtile.core.name == "wayland":
    wmname = "Qtile (Wayland)"

# wayland-specific settings
if qtile.core.name == "wayland":
    # input
    wl_input_rules = {
        "type:keyboard": InputConfig(kb_repeat_delay=300, kb_repeat_rate=50),
    }

    # cursor
    wl_xcursor_theme = "phinger-cursors-light"
    wl_xcursor_size = 24

    # enable tty switching
    for vt in range(1, 8):
        keys.append(
            Key(["control", "mod1"], f"f{vt}", lazy.core.change_vt(vt)),
        )

# Bar
widget_defaults = dict(font="Ubuntu Nerd Font Medium", foreground=colors[0])

wlan_defaults = dict(
    disconnected_message="",
    ethernet_message="",
    fontsize=16,
    format="({percent:2.0%})",
    padding=2,
    use_ethernet=True,
)

decoration_group = {
    "decorations": [
        RectDecoration(
            colour=colors[2], radius=15, filled=True, padding_y=4, group=True
        )
    ],
}

decoration_group_width = {
    "decorations": [
        RectDecoration(
            colour=colors[2],
            radius=15,
            filled=True,
            padding_y=4,
            extrawidth=4,
            group=True,
        )
    ],
}

spacer = widget.Spacer(length=5)

spacer2 = widget.Spacer(length=10)

clock_icon = widget.TextBox(
    text=" ", **widget_defaults, fontsize=20, padding=2, **decoration_group_width
)

clock = widget.Clock(
    format="%H:%M", fontsize=16, **widget_defaults, padding=2, **decoration_group_width
)

date_icon = widget.TextBox(
    text=" ", fontsize=20, **widget_defaults, padding=2, **decoration_group_width
)

date = widget.Clock(
    format="%d-%m-%Y",
    fontsize=16,
    **widget_defaults,
    padding=2,
    **decoration_group_width,
)

systray = widget.Systray(icon_size=20, **widget_defaults, padding=0)

systrayV2 = widget.StatusNotifier(
    icon_size=20,
    icon_theme="Mint-Y-Sand",
    **widget_defaults,
    padding=4,
    **decoration_group_width,
)

groupbox = widget.GroupBox(
    use_mouse_wheel=False,
    urgent_alert_method="text",
    urgent_text=colors[3],
    fontsize=16,
    spacing=None,
    padding_x=1,
    highlight_color=colors[1],
    highlight_method="line",
    inactive=colors[2],
    active=colors[0],
    this_current_screen_border=colors[0],
    other_screen_border=colors[2],
    this_screen_border=colors[2],
    other_current_screen_border=colors[0],
    borderwidth=4,
    font="Ubuntu Nerd Font Bold",
    padding=4,
    hide_unused=True,
)

groupbox2 = widget.GroupBox(
    use_mouse_wheel=False,
    urgent_alert_method="text",
    urgent_text=colors[3],
    fontsize=16,
    spacing=None,
    padding_x=1,
    highlight_color=colors[1],
    highlight_method="line",
    inactive=colors[2],
    active=colors[0],
    this_current_screen_border=colors[0],
    other_screen_border=colors[2],
    this_screen_border=colors[2],
    other_current_screen_border=colors[0],
    borderwidth=4,
    font="Ubuntu Nerd Font Bold",
    padding=4,
    hide_unused=True,
)

l_icon = widget.CurrentLayoutIcon(
    scale=0.5, padding=2, **widget_defaults, use_mask=True, **decoration_group_width
)

l_icon2 = widget.CurrentLayoutIcon(
    scale=0.5, padding=2, **widget_defaults, use_mask=True, **decoration_group_width
)

l = widget.CurrentLayout(
    fontsize=16, **widget_defaults, padding=0, **decoration_group_width
)

l2 = widget.CurrentLayout(
    fontsize=16, **widget_defaults, padding=0, **decoration_group_width
)

window_icon = widget.TextBox(
    text=" ", fontsize=20, **widget_defaults, padding=2, **decoration_group
)

window_name = widget.WindowName(
    format="{name}",
    max_chars=40,
    fontsize=16,
    **widget_defaults,
    padding=2,
    **decoration_group,
    width=320,
)

window_name2 = widget.WindowName(
    format="{name}",
    max_chars=40,
    fontsize=16,
    **widget_defaults,
    padding=2,
    **decoration_group,
    width=320,
)

music_icon = widget.TextBox(
    text=" 󰝚", fontsize=20, **widget_defaults, padding=2, **decoration_group_width
)

now_playing = widget.Mpris2(
    format="{xesam:title} - {xesam:artist}",
    max_chars=30,
    no_metadata_text="",
    paused_text="{track}",
    playing_text="{track}",
    poll_interval=5,
    fontsize=16,
    **widget_defaults,
    padding=2,
    **decoration_group_width,
)

nixos_icon = widget.TextBox(
    text=" ", fontsize=20, **widget_defaults, padding=2, **decoration_group_width
)

os_version = widget.GenPollText(
    func=lambda: subprocess.check_output(
        home + "/repos/configs/scripts/waybar/os-version.sh", shell=True, text=True
    ).strip(),
    update_interval=60,
    fontsize=16,
    **widget_defaults,
    padding=2,
    **decoration_group_width,
)

# NetUP is not available until updated to qtile version 0.33.0!
# network = widget.NetUP(
#  display_fmt='{0}',
#  down_foreground=colors[3],
#  down_string='',
#  fontsize=16,
#  up_foreground=colors[0],
#  up_string='',
#  **widget_defaults,
#  **decoration_group_width
# )

wifi_icon = widget.TextBox(
    text="󰖩", fontsize=20, **widget_defaults, padding=2, **decoration_group_width
)

kernel_icon = widget.TextBox(
    text=" ", fontsize=20, **widget_defaults, padding=2, **decoration_group_width
)

kernel_version = widget.GenPollText(
    func=lambda: subprocess.check_output("uname -r", shell=True, text=True).strip(),
    update_interval=60,
    fontsize=16,
    **widget_defaults,
    padding=2,
    **decoration_group_width,
)

cpu_icon = widget.TextBox(
    text="󰻠", fontsize=24, **widget_defaults, padding=2, **decoration_group_width
)

cpu_temp = widget.ThermalSensor(
    tag_sensor="Tctl",
    fontsize=16,
    update_interval=5,
    threshold=85,
    **widget_defaults,
    padding=0,
    **decoration_group_width,
)

gpu_icon = widget.TextBox(
    text=" 󰢮", fontsize=26, **widget_defaults, padding=2, **decoration_group_width
)

gpu_temp = widget.ThermalSensor(
    tag_sensor="edge",
    fontsize=16,
    update_interval=5,
    threshold=80,
    **widget_defaults,
    padding=0,
    **decoration_group_width,
)

mem_icon = widget.TextBox(
    text="  ", fontsize=18, **widget_defaults, padding=0, **decoration_group_width
)

memory = widget.Memory(
    fontsize=16,
    update_interval=5,
    **widget_defaults,
    padding=0,
    **decoration_group_width,
)

ds5_icon = widget.GenPollText(
    func=lambda: subprocess.check_output(
        home + "/repos/configs/scripts/qtile-bar/dualsense-icon.sh",
        shell=True,
        text=True,
    ).strip(),
    update_interval=60,
    fontsize=20,
    **widget_defaults,
    padding=4,
    **decoration_group_width,
)

ds5_bat = widget.GenPollText(
    func=lambda: subprocess.check_output(
        home + "/repos/configs/scripts/qtile-bar/dualsense.sh", shell=True, text=True
    ).strip(),
    update_interval=60,
    fontsize=16,
    **widget_defaults,
    padding=2,
    **decoration_group_width,
)

current_screen = widget.CurrentScreen(
    active_color=colors[0],
    active_text="",
    inactive_color=colors[2],
    inactive_text="",
    **widget_defaults,
    fontsize=26,
)

current_screen2 = widget.CurrentScreen(
    active_color=colors[0],
    active_text="",
    inactive_color=colors[2],
    inactive_text="",
    **widget_defaults,
    fontsize=26,
)
