# Qile config

# Import libraries
#from libqtile.lazy import lazy
from libqtile.config import Key, Click, Drag, Group, Match, Screen, ScratchPad, DropDown
from libqtile import layout, bar, qtile
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
import os
import sys
sys.path.append(os.path.expanduser('~') + '/repos/configs/dotfiles/common/dotconfig/qtile')
from common import *

# Keybindings
keys.extend(
  [
    # open RGB light color switcher
    Key([mod, "shift"], "o", lazy.spawn(home + '/repos/configs/scripts/dmenu/rgb-switcher.sh') ),
  ]
)

if qtile.core.name == "x11":
  keys.extend(
    [
      # Switch focus between monitors
      Key([mod, "control"], "Down", lazy.to_screen(0) ),
      Key([mod, "control"], "Up", lazy.to_screen(1) ),
    ]
  )

elif qtile.core.name == "wayland":
  keys.extend(
    [
      # Switch focus between monitors
      Key([mod, "control"], "Down", lazy.to_screen(1) ),
      Key([mod, "control"], "Up", lazy.to_screen(0) ),
    ]
  )

widget_defaults = dict(
  font="Ubuntu Nerd Font Medium",
  foreground=colors[0]
)

decoration_group = {
  "decorations": [
    RectDecoration(colour=colors[2], radius=15, filled=True, padding_y=4, group=True)
  ],
}

decoration_group_width = {
  "decorations": [
    RectDecoration(colour=colors[2], radius=15, filled=True, padding_y=4, extrawidth=4, group=True)
  ],
}

spacer = widget.Spacer(
           length=5)

spacer2 = widget.Spacer(
            length=10)

clock_icon = widget.TextBox(
            text=" ",
            **widget_defaults,
            fontsize=20,
            padding=2,
            **decoration_group_width)

clock = widget.Clock(
            format='%H:%M',
            fontsize=16,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

date_icon = widget.TextBox(
            text=" ",
            fontsize=18,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

date = widget.Clock(
            format='%d-%m-%Y',
            fontsize=16,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

systray = widget.Systray(
            icon_size=20,
            **widget_defaults,
            padding=0)

systrayV2 = widget.StatusNotifier(
              icon_size=20,
              icon_theme="Mint-Y-Sand",
              **widget_defaults,
              padding=0,
              **decoration_group_width)

groupbox = widget.GroupBox(
            use_mouse_wheel=False,
            urgent_alert_method='text',
            urgent_text=colors[3],
            fontsize=16,
            spacing=None,
            padding_x=1,
            highlight_color=colors[1],
            highlight_method='line',
            inactive=colors[2],
            active=colors[0],
            this_current_screen_border=colors[0],
            other_screen_border=colors[2],
            this_screen_border=colors[2],
            other_current_screen_border=colors[0],
            borderwidth=4,
            font="Ubuntu Nerd Font Bold",
            padding=4,
	    hide_unused=True)

groupbox2 = widget.GroupBox(
            use_mouse_wheel=False,
            urgent_alert_method='text',
            urgent_text=colors[3],
            fontsize=16,
            spacing=None,
            padding_x=1,
            highlight_color=colors[1],
            highlight_method='line',
            inactive=colors[2],
            active=colors[0],
            this_current_screen_border=colors[0],
            other_screen_border=colors[2],
            this_screen_border=colors[2],
            other_current_screen_border=colors[0],
            borderwidth=4,
            font="Ubuntu Nerd Font Bold",
            padding=4,
            hide_unused=True)

l_icon = widget.CurrentLayoutIcon(
            scale=0.5,
            padding=2,
	    **widget_defaults,
	    use_mask=True,
            **decoration_group_width)

l_icon2 = widget.CurrentLayoutIcon(
            scale=0.5,
            padding=2,
	    **widget_defaults,
	    use_mask=True,
            **decoration_group_width)

l = widget.CurrentLayout(
            fontsize=16,
            **widget_defaults,
            padding=0,
            **decoration_group_width)

l2 = widget.CurrentLayout(
            fontsize=16,
            **widget_defaults,
            padding=0,
            **decoration_group_width)

window_icon = widget.TextBox(
            text=" ",
            fontsize=20,
            **widget_defaults,
            padding=2,
            **decoration_group)

window_name = widget.WindowName(
            format='{name}',
            max_chars=50,
            fontsize=16,
            **widget_defaults,
            padding=2,
            **decoration_group,
            width=420)

window_name2 = widget.WindowName(
            format='{name}',
            max_chars=50,
            fontsize=16,
            **widget_defaults,
            padding=2,
            **decoration_group,
            width=420)

music_icon = widget.TextBox(
            text=" 󰝚",
            fontsize=20,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

now_playing = widget.Mpris2(
            format='{xesam:title} - {xesam:artist}',
            max_chars=30,
	    no_metadata_text='',
            paused_text='{track}',
            playing_text='{track}',
	    poll_interval=5,
            fontsize=16,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

nixos_icon = widget.TextBox(
            text=" ",
            fontsize=20,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

os_version = widget.GenPollText(
            func=lambda: subprocess.check_output(home + '/repos/configs/scripts/waybar/os-version.sh', shell=True, text=True).strip(),
            update_interval=60,
            fontsize=16,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

kernel_icon = widget.TextBox(
            text=" ",
            fontsize=20,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

kernel_version = widget.GenPollText(
            func=lambda: subprocess.check_output("uname -r", shell=True, text=True).strip(),
            update_interval=60,
            fontsize=16,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

cpu_icon = widget.TextBox(
            text="󰻠",
            fontsize=24,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

cpu_temp = widget.ThermalSensor(
            tag_sensor="Tctl",
            fontsize=16,
            update_interval=5,
            threshold=85,
            **widget_defaults,
            padding=0,
            **decoration_group_width)

gpu_icon = widget.TextBox(
            text=" ",
            fontsize=20,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

gpu_temp = widget.ThermalSensor(
            tag_sensor="edge",
            fontsize=16,
            update_interval=5,
            threshold=80,
            **widget_defaults,
            padding=0,
            **decoration_group_width)

water_icon = widget.TextBox(
            text="󰖌",
            fontsize=20,
            **widget_defaults,
            padding=0,
            **decoration_group_width)

water_temp = widget.ThermalSensor(
            tag_sensor="Coolant",
            fontsize=16,
            update_interval=5,
            **widget_defaults,
            padding=0,
            **decoration_group_width)

pump_icon = widget.TextBox(
            text="󱩃",
            fontsize=20,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

pump_rpm = widget.GenPollText(
            func=lambda: subprocess.check_output("sensors | awk '/Pump/ {print $2" "$3}'", shell=True, text=True).strip(),
            update_interval=5,
            fontsize=16,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

fan_icon = widget.TextBox(
            text="󰈐",
            fontsize=20,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

fan_rpm = widget.GenPollText(
            func=lambda: subprocess.check_output("sensors | awk '/fan2/ {print $3" "$4}'", shell=True, text=True).strip(),
            update_interval=5,
            fontsize=16,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

mem_icon = widget.TextBox(
            text="  ",
            fontsize=18,
            **widget_defaults,
            padding=0,
            **decoration_group_width)

memory = widget.Memory(
            fontsize=16,
            update_interval=5,
            **widget_defaults,
            padding=0,
            **decoration_group_width)

ds5_icon = widget.GenPollText(
             func=lambda: subprocess.check_output(home + '/repos/configs/scripts/qtile-bar/dualsense-icon.sh', shell=True, text=True).strip(),
             update_interval=60,
             fontsize=20,
             **widget_defaults,
             padding=2,
             **decoration_group_width)

ds5_bat = widget.GenPollText(
            func=lambda: subprocess.check_output(home + '/repos/configs/scripts/qtile-bar/dualsense.sh', shell=True, text=True).strip(),
            update_interval=60,
            fontsize=16,
            **widget_defaults,
            padding=2,
            **decoration_group_width)

current_screen = widget.CurrentScreen(
                   active_color=colors[0],
                   active_text='',
                   inactive_color=colors[2],
                   inactive_text='',
                   **widget_defaults,
		   fontsize=26)

current_screen2 = widget.CurrentScreen(
                   active_color=colors[0],
                   active_text='',
                   inactive_color=colors[2],
                   inactive_text='',
                   **widget_defaults,
		   fontsize=26)

screens = [
  Screen(top=bar.Bar([
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
    spacer,
    nixos_icon,
    os_version,
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
    spacer

  ], 38,
     background=colors[1],
     margin=[10,10,0,10],
     border_width=[0,0,0,0],
     border_color=colors[0]), ),

  Screen(top=bar.Bar([
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
    spacer,
    nixos_icon,
    os_version,
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
    spacer

  ], 38,
     background=colors[1],
     margin=[10,10,0,10],
     border_width=[0,0,0,0],
     border_color=colors[0]), ),
]
