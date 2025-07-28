# Qtile laptop config

# Import libraries
from libqtile.config import Key, Click, Drag, Group, Match, Screen, ScratchPad, DropDown
from libqtile import layout, bar, qtile
import os
import subprocess
import sys
sys.path.append(os.path.expanduser('~') + '/repos/configs/dotfiles/common/dotconfig/qtile')
from common import *

# Keybindings
keys.extend(
  [
    # laptop brightness controls
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 10%-") ),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s +10%") ),

    # laptop volume controls
    Key([], "XF86AudioMute", lazy.spawn("pulsemixer --toggle-mute") ),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pulsemixer --change-volume -5") ),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pulsemixer --change-volume +5") ),
  ]
)

# wayland-specific settings
if qtile.core.name == "wayland":
  # input
  wl_input_rules_laptop = {
    "type:touchpad": InputConfig(dwt=False, tap=True),
  }

  wl_input_rules.update(wl_input_rules_laptop)

# Bar 
wifi = widget.Wlan(
  #ethernet_interface='enp5s0',
  interface='wlp1s0',
  **wlan_defaults,
  **widget_defaults,
  **decoration_group_width
)

battery = widget.Battery(
  battery=0,
  charge_char='󰂄',
  discharge_char='󰂍',
  empty_char='󱃍',
  full_char='󰁹',
  low_foreground=colors[3],
  format='{char} {percent:2.0%} - {hour:d}:{min:02d}',
  low_percentage=0.15,
  padding=2,
  foreground=colors[0],
  font="Ubuntu Nerd Font Medium",
  fontsize=16,
  **decoration_group
)

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
    spacer2,
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
    #spacer,
    #nixos_icon,
    #os_version,
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
    mem_icon,
    memory,
    spacer2,
    ds5_icon,
    ds5_bat,
    spacer,
    battery,
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
    #spacer,
    #nixos_icon,
    #os_version,
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
    mem_icon,
    memory,
    spacer2,
    ds5_icon,
    ds5_bat,
    spacer,
    battery,
    spacer

  ], 38,
     background=colors[1],
     margin=[10,10,0,10],
     border_width=[0,0,0,0],
     border_color=colors[0]), ),
]