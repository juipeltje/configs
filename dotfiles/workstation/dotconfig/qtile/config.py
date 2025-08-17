# Qtile workstation config

# Import libraries
from libqtile.config import Key, Click, Drag, Group, Match, Screen, ScratchPad, DropDown
from libqtile import layout, bar, qtile
import os
import sys
sys.path.append(os.path.expanduser("~") + "/repos/configs/dotfiles/common/dotconfig/qtile")
from common import *

# Keybindings
keys.extend(
    [
        # open RGB light color switcher
        Key([mod, "shift"], "o", lazy.spawn(home + "/repos/configs/scripts/dmenu/rgb-switcher.sh"),),
    ]
)

if qtile.core.name == "x11":
    keys.extend(
        [
            # Switch focus between monitors
            Key([mod, "control"], "Down", lazy.to_screen(0)),
            Key([mod, "control"], "Up", lazy.to_screen(1)),
        ]
    )

elif qtile.core.name == "wayland":
    keys.extend(
        [
            # Switch focus between monitors
            Key([mod, "control"], "Down", lazy.to_screen(1)),
            Key([mod, "control"], "Up", lazy.to_screen(0)),
        ]
    )

# Bar
wifi = widget.Wlan(
    ethernet_interface="enp5s0",
    interface="wlp4s0",
    **wlan_defaults,
    **widget_defaults,
    **decoration_group_width,
)

water_icon = widget.TextBox(
    text="󰖌", fontsize=24, **widget_defaults, padding=0, **decoration_group_width
)

water_temp = widget.ThermalSensor(
    tag_sensor="Coolant",
    fontsize=16,
    update_interval=5,
    **widget_defaults,
    padding=0,
    **decoration_group_width,
)

pump_icon = widget.TextBox(
    text="󱩃", fontsize=22, **widget_defaults, padding=2, **decoration_group_width
)

pump_rpm = widget.GenPollText(
    func=lambda: subprocess.check_output(
        "sensors | awk '/Pump/ {print $2$3}'", shell=True, text=True
    ).strip(),
    update_interval=5,
    fontsize=16,
    **widget_defaults,
    padding=2,
    **decoration_group_width,
)

fan_icon = widget.TextBox(
    text="󰈐", fontsize=22, **widget_defaults, padding=2, **decoration_group_width
)

fan_rpm = widget.GenPollText(
    func=lambda: subprocess.check_output(
        "sensors | awk '/fan2/ {print $3$4}'", shell=True, text=True
    ).strip(),
    update_interval=5,
    fontsize=16,
    **widget_defaults,
    padding=2,
    **decoration_group_width,
)

screens = [
    Screen(
        top=bar.Bar(
            [
                spacer,
                clock_icon,
                clock,
                spacer2,
                date_icon,
                date,
                spacer2,
                systrayV2,
                current_screen,
                groupbox,
                l_icon,
                l,
                spacer2,
                window_icon,
                window_name,
                widget.Spacer(),
                music_icon,
                now_playing,
                # spacer,
                # nixos_icon,
                # os_version,
                spacer,
                wifi_icon,
                wifi,
                spacer,
                kernel_icon,
                kernel_version,
                spacer,
                cpu_icon,
                cpu_temp,
                spacer,
                gpu_icon,
                gpu_temp,
                spacer,
                water_icon,
                water_temp,
                spacer,
                pump_icon,
                pump_rpm,
                spacer,
                fan_icon,
                fan_rpm,
                spacer,
                mem_icon,
                memory,
                spacer2,
                ds5_icon,
                ds5_bat,
                spacer,
            ],
            38,
            background=colors[1],
            margin=[10, 10, 0, 10],
            border_width=[0, 0, 0, 0],
            border_color=colors[0],
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                spacer,
                clock_icon,
                clock,
                spacer2,
                date_icon,
                date,
                spacer2,
                systrayV2,
                current_screen2,
                groupbox2,
                l_icon2,
                l2,
                spacer2,
                window_icon,
                window_name2,
                widget.Spacer(),
                music_icon,
                now_playing,
                # spacer,
                # nixos_icon,
                # os_version,
                spacer,
                wifi_icon,
                wifi,
                spacer,
                kernel_icon,
                kernel_version,
                spacer,
                cpu_icon,
                cpu_temp,
                spacer,
                gpu_icon,
                gpu_temp,
                spacer,
                water_icon,
                water_temp,
                spacer,
                pump_icon,
                pump_rpm,
                spacer,
                fan_icon,
                fan_rpm,
                spacer,
                mem_icon,
                memory,
                spacer2,
                ds5_icon,
                ds5_bat,
                spacer,
            ],
            38,
            background=colors[1],
            margin=[10, 10, 0, 10],
            border_width=[0, 0, 0, 0],
            border_color=colors[0],
        ),
    ),
]
