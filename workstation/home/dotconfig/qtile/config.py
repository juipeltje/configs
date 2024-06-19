# Qtile config

# Import libraries
from libqtile.command import lazy
from libqtile.config import Key, Click, Drag, Group, Match, Screen, ScratchPad, DropDown
from libqtile import layout, hook, bar
from qtile_extras import widget
import os
import subprocess
import sys
sys.path.append(os.path.expanduser('~') + '/repos/configs/common/home/dotconfig/qtile')
from common import *

# autostart programs when starting window manager
@hook.subscribe.startup_once
def autostart():
    subprocess.Popen([home + '/.config/qtile/autostart.sh'])

# Keybindings
keys += [

  # Switch focus between monitors
  Key([mod, "control"], "Down", lazy.to_screen(0) ),
  Key([mod, "control"], "Up", lazy.to_screen(1) ),

]

widget_defaults = dict(
  font="Ubuntu Nerd Font Medium",
  foreground=colors[0]
)

spacer = widget.Spacer(
           length=5)

spacer2 = widget.Spacer(
            length=10)

clock_icon = widget.TextBox(
            text="",
            **widget_defaults,
            fontsize=20,
            padding=2)

clock = widget.Clock(
            format='%H:%M',
            fontsize=16,
            **widget_defaults,
            padding=2)

date_icon = widget.TextBox(
            text="",
            fontsize=18,
            **widget_defaults,
            padding=2)

date = widget.Clock(
            format='%d-%m-%Y',
            fontsize=16,
            **widget_defaults,
            padding=2)

systray = widget.Systray(
            icon_size=20,
            **widget_defaults,
            padding=0)

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
            scale=0.7,
            padding=2,
	    **widget_defaults,
	    use_mask=True)

l_icon2 = widget.CurrentLayoutIcon(
            scale=0.7,
            padding=2,
	    **widget_defaults,
	    use_mask=True)

l = widget.CurrentLayout(
            fontsize=16,
            **widget_defaults,
            padding=0)

l2 = widget.CurrentLayout(
            fontsize=16,
            **widget_defaults,
            padding=0)

window_icon = widget.TextBox(
            text="",
            fontsize=20,
            **widget_defaults,
            padding=2)

window_name = widget.WindowName(
            format='{name}',
            max_chars=50,
            fontsize=16,
            **widget_defaults,
            padding=2)

window_name2 = widget.WindowName(
            format='{name}',
            max_chars=50,
            fontsize=16,
            **widget_defaults,
            padding=2)

music_icon = widget.TextBox(
            text="󰝚",
            fontsize=20,
            **widget_defaults,
            padding=2)

now_playing = widget.Mpris2(
            format='{xesam:title} - {xesam:artist}',
            max_chars=30,
	    no_metadata_text='',
            paused_text='{track}',
            playing_text='{track}',
	    poll_interval=5,
            fontsize=16,
            **widget_defaults,
            padding=2)

void_icon = widget.TextBox(
            text="",
            fontsize=20,
            **widget_defaults,
            padding=2)

kernel_version = widget.GenPollText(
            func=lambda: subprocess.check_output("uname -r", shell=True, text=True).strip(),
            update_interval=60,
            fontsize=16,
            **widget_defaults,
            padding=2)

cpu_icon = widget.TextBox(
            text="󰻠",
            fontsize=24,
            **widget_defaults,
            padding=2)

cpu_temp = widget.ThermalSensor(
            tag_sensor="Tctl",
            fontsize=16,
            update_interval=5,
            threshold=85,
            **widget_defaults,
            padding=0)

gpu_icon = widget.TextBox(
            text="",
            fontsize=20,
            **widget_defaults,
            padding=2)

gpu_temp = widget.ThermalSensor(
            tag_sensor="edge",
            fontsize=16,
            update_interval=5,
            threshold=80,
            **widget_defaults,
            padding=0)

water_icon = widget.TextBox(
            text="󰖌",
            fontsize=20,
            **widget_defaults,
            padding=0)

water_temp = widget.ThermalSensor(
            tag_sensor="Coolant",
            fontsize=16,
            update_interval=5,
            **widget_defaults,
            padding=0)

pump_icon = widget.TextBox(
            text="󱩃",
            fontsize=20,
            **widget_defaults,
            padding=2)

pump_rpm = widget.GenPollText(
            func=lambda: subprocess.check_output("sensors | awk '/Pump/ {print $2" "$3}'", shell=True, text=True).strip(),
            update_interval=5,
            fontsize=16,
            **widget_defaults,
            padding=2)

fan_icon = widget.TextBox(
            text="󰈐",
            fontsize=20,
            **widget_defaults,
            padding=2)

fan_rpm = widget.GenPollText(
            func=lambda: subprocess.check_output("sensors | awk '/fan2/ {print $3" "$4}'", shell=True, text=True).strip(),
            update_interval=5,
            fontsize=16,
            **widget_defaults,
            padding=2)

mem_icon = widget.TextBox(
            text=" ",
            fontsize=18,
            **widget_defaults,
            padding=0)

memory = widget.Memory(
            fontsize=16,
            update_interval=5,
            **widget_defaults,
            padding=0)

ds5_icon = widget.TextBox(
            text="󰖺",
            fontsize=20,
            **widget_defaults,
            padding=2)

ds5_bat = widget.GenPollText(
            func=lambda: subprocess.check_output(home + '/repos/configs/scripts/dualsense-bat.sh', shell=True, text=True).strip(),
            update_interval=60,
            fontsize=16,
            **widget_defaults,
            padding=2)

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
    systray,
    current_screen,
    groupbox,
    l_icon,
    spacer,
    l,
    spacer2,
    window_icon,
    window_name,
    music_icon,
    now_playing,
    spacer,
    void_icon,
    kernel_version,
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
    current_screen2,
    groupbox2,
    l_icon2,
    spacer,
    l2,
    spacer2,
    window_icon,
    window_name2,
    music_icon,
    now_playing,
    spacer,
    void_icon,
    kernel_version,
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
