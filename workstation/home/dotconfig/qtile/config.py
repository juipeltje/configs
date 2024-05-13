# Qtile config

# Import libraries

from libqtile.command import lazy
from libqtile.config import Key, Click, Drag, Group, Match, Screen, ScratchPad, DropDown
from libqtile import layout, hook, bar, widget
import os
import subprocess

# autostart programs when starting window manager

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

# Variables 

mod = "mod4"
terminal = "alacritty"
webbrowser = "firefox"
file_manager = "pcmanfm" 

# Keybindings

keys = [

  # Open a terminal
  
  Key([mod], "t", lazy.spawn(terminal) ),

  # Open a file manager

  Key([mod], "f", lazy.spawn(file_manager) ),

  # Open a webbrowser

  Key([mod], "w", lazy.spawn(webbrowser) ),

  # Open pavucontrol

  Key([mod], "a", lazy.spawn("pavucontrol") ),

  # Open Deezer in firefox tab

  Key([mod], "d", lazy.spawn("firefox -new-window https://www.deezer.com/en/") ),
  
  # Rofi power menu, application launcher, and window switcher
  
  Key([mod], "Escape", lazy.spawn("/home/joppe/repos/configs/Scripts/rofi-powermenu-qtile.sh") ), 
  Key([mod], "space", lazy.spawn("rofi -show drun -show-icons -icon-theme Papirus-Dark") ), 
  Key([mod], "Tab", lazy.spawn("rofi -show window -show-icons -icon-theme Papirus-Dark") ), 
  
  # Dunst notification history and close all notifications
  
  Key([mod], "n", lazy.spawn("dunstctl history-pop") ), 
  Key([mod], "c", lazy.spawn("dunstctl close-all") ), 

  # play/pause/previous/next keyboard controls
  
  Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause") ), 
  Key([], "XF86AudioNext", lazy.spawn("playerctl next") ), 
  Key([], "XF86AudioPrev", lazy.spawn("playerctl previous") ), 

  # Start/stop picom keybindings for playing games
  
  Key([mod], "g", lazy.spawn("/home/joppe/repos/configs/Scripts/start-gamemode.sh") ), 
  Key([mod], "p", lazy.spawn("/home/joppe/repos/configs/Scripts/stop-gamemode.sh") ), 

  # Reload config and restart qtile

  Key([mod], "r", lazy.reload_config() ), 
  Key([mod, "control"], "r", lazy.restart(), ), 

  # Kill a window
  
  Key([mod], "q", lazy.window.kill() ), 

  # Switch focused window

  Key([mod], "Right", lazy.layout.right() ), 
  Key([mod], "Left", lazy.layout.left() ),
  Key([mod], "Up", lazy.layout.up() ),
  Key([mod], "Down", lazy.layout.down() ),

  # Toggle floating window

  Key([mod, "shift"], "space", lazy.window.toggle_floating() ),

  # Toggle fullscreen

  Key([mod, "shift"], "f", lazy.window.toggle_fullscreen() ),

  # Grow windows 

  Key([mod, "mod1"], "Right", lazy.layout.grow_right() ),
  Key([mod, "mod1"], "Left", lazy.layout.grow_left() ),
  Key([mod, "mod1"], "Up", lazy.layout.grow_up() ),
  Key([mod, "mod1"], "Down", lazy.layout.grow_down() ),

  # Move windows between left/right columns or move up/down in current stack

  Key([mod, "shift"], "Right", lazy.layout.shuffle_right() ),
  Key([mod, "shift"], "Left", lazy.layout.shuffle_left() ),
  Key([mod, "shift"], "Up", lazy.layout.shuffle_up() ),
  Key([mod, "shift"], "Down", lazy.layout.shuffle_down() ),

  # Grow/shrink windows in layout and reset

  Key([mod, "mod2"], "KP_Add", lazy.layout.grow() ),
  Key([mod, "mod2"], "KP_Subtract", lazy.layout.shrink() ),
  Key([mod, "mod2"], "KP_Enter", lazy.layout.reset() ),

  # Toggle between the different layouts

  Key([mod], "l", lazy.next_layout() ),

  # Go to next/previous group

  Key([mod, "control"], "Right", lazy.screen.next_group() ),
  Key([mod, "control"], "Left", lazy.screen.prev_group() ),

  # Switch focus between monitors

  Key([mod, "control"], "Down", lazy.to_screen(0) ),
  Key([mod, "control"], "Up", lazy.to_screen(1) ),

  # Toggle Scratchpad

  Key([mod], "s", lazy.group['0'].dropdown_toggle('term') ),

]

mouse = [
  
  # Dragging and resizing floating windows with mod + mouse buttons

  Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position() ),
  Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size() ),

]

groups = [

  Group("1", layout="monadtall", label="1"),
  Group("2", layout="monadtall", label="2"),
  Group("3", layout="monadtall", label="3"),
  Group("4", layout="monadtall", label="4"),
  Group("5", layout="monadtall", label="5"),
  Group("6", layout="monadtall", label="6"),
  Group("7", layout="monadtall", label="7"),
  Group("8", layout="monadtall", label="8"),

]


for i in groups:
  keys.extend(
    [

      # mod + number of group = switch to group
      
      Key([mod], i.name, lazy.group[i.name].toscreen() ),

      # switch between groups using the numpad
      
      Key([mod, "mod2"], "KP_End", lazy.group["1"].toscreen() ),
      Key([mod, "mod2"], "KP_Down", lazy.group["2"].toscreen() ),
      Key([mod, "mod2"], "KP_Next", lazy.group["3"].toscreen() ),
      Key([mod, "mod2"], "KP_Left", lazy.group["4"].toscreen() ),
      Key([mod, "mod2"], "KP_Begin", lazy.group["5"].toscreen() ),
      Key([mod, "mod2"], "KP_Right", lazy.group["6"].toscreen() ),
      Key([mod, "mod2"], "KP_Home", lazy.group["7"].toscreen() ),
      Key([mod, "mod2"], "KP_Up", lazy.group["8"].toscreen() ),


      # mod + shift + number of group = switch to & move focused window to group

      # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True) ),

      # switch to and move focused window to group using the numpad

      # Key([mod, "mod2", "shift"], "KP_End", lazy.window.togroup("1", switch_group=True) ),
      # Key([mod, "mod2", "shift"], "KP_Down", lazy.window.togroup("2", switch_group=True) ),
      # Key([mod, "mod2", "shift"], "KP_Next", lazy.window.togroup("3", switch_group=True) ),
      # Key([mod, "mod2", "shift"], "KP_Left", lazy.window.togroup("4", switch_group=True) ),
      # Key([mod, "mod2", "shift"], "KP_Begin", lazy.window.togroup("5", switch_group=True) ),
      # Key([mod, "mod2", "shift"], "KP_Right", lazy.window.togroup("6", switch_group=True) ),
      # Key([mod, "mod2", "shift"], "KP_Home", lazy.window.togroup("7", switch_group=True) ),
      # Key([mod, "mod2", "shift"], "KP_Up", lazy.window.togroup("8", switch_group=True) ),

      # use this if you don't want to switch to the group that the window was moved to

      Key([mod, "shift"], i.name, lazy.window.togroup(i.name) ),

      # use this if you don't want to switch to the group that the window was moved to with the numpad

      Key([mod, "mod2", "shift"], "KP_End", lazy.window.togroup("1") ),
      Key([mod, "mod2", "shift"], "KP_Down", lazy.window.togroup("2") ),
      Key([mod, "mod2", "shift"], "KP_Next", lazy.window.togroup("3") ),
      Key([mod, "mod2", "shift"], "KP_Left", lazy.window.togroup("4") ),
      Key([mod, "mod2", "shift"], "KP_Begin", lazy.window.togroup("5") ),
      Key([mod, "mod2", "shift"], "KP_Right", lazy.window.togroup("6") ),
      Key([mod, "mod2", "shift"], "KP_Home", lazy.window.togroup("7") ),
      Key([mod, "mod2", "shift"], "KP_Up", lazy.window.togroup("8") ),

  ]
)

# Scratchpad window settings 

groups.append(ScratchPad("0", [ DropDown("term", "alacritty", opacity=1, width=0.4, height=0.6, x=0.3, y=0.2, on_focus_lost_hide=False), ]),

)

layout_theme = {
                "border_focus":'#dfbf8e',
                "border_normal":'#665c54',
                "border_width":4,
                "margin":10,
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

widget_defaults = dict(
  font="Ubuntu Nerd Font Medium",
  foreground='dfbf8e'
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
            urgent_text='ea6962',
            fontsize=16,
            spacing=None,
            padding_x=1,
            highlight_color=['000000', 'a89984'],
            highlight_method='default',
            inactive='928374',
            active='dfbf8e',
            this_current_screen_border='8ec07c',
            other_screen_border='d3869b',
            this_screen_border='8ec07c',
            other_current_screen_border='d3869b',
            borderwidth=4,
            font="Ubuntu Nerd Font Bold",
            padding=4)

groupbox2 = widget.GroupBox(
            use_mouse_wheel=False,
            urgent_alert_method='text',
            urgent_text='ea6962',
            fontsize=16,
            spacing=None,
            padding_x=1,
            highlight_color=['000000', 'a89984'],
            highlight_method='default',
            inactive='928374',
            active='dfbf8e',
            this_current_screen_border='d3869b',
            other_screen_border='8ec07c',
            this_screen_border='d3869b',
            other_current_screen_border='8ec07c',
            borderwidth=4,
            font="Ubuntu Nerd Font Bold",
            padding=4)

l_icon = widget.CurrentLayoutIcon(
            scale=0.7,
            padding=2)

l_icon2 = widget.CurrentLayoutIcon(
            scale=0.7,
            padding=2)

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
            display_metadata=["xesam:title", "xesam:artist"],
            max_chars=30,
            paused_text='{track}',
            playing_text='{track}',
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
            fontsize=20,
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
            text="",
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
            func=lambda: subprocess.check_output("sensors | grep Pump | awk '{print $2" "$3}'", shell=True, text=True).strip(),
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
            func=lambda: subprocess.check_output("sensors | grep fan2 | awk '{print $3" "$4}'", shell=True, text=True).strip(),
            update_interval=5,
            fontsize=16,
            **widget_defaults,
            padding=2)

mem_icon = widget.TextBox(
            text="󰍛",
            fontsize=20,
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
            func=lambda: subprocess.check_output("/home/joppe/repos/configs/Scripts/controller-battery.sh", shell=True, text=True).strip(),
            update_interval=60,
            fontsize=16,
            **widget_defaults,
            padding=2)

power = widget.TextBox(
            text="",
            fontsize=20,
            font="Ubuntu Nerd Font Medium",
            foreground='ea6962',
            padding=4)

current_screen = widget.CurrentScreen(
                   active_color='dfbf8e',
                   active_text='󰍹',
                   inactive_color='928374',
                   inactive_text='󰍹',
                   **widget_defaults)

current_screen2 = widget.CurrentScreen(
                   active_color='dfbf8e',
                   active_text='󰍹',
                   inactive_color='928374',
                   inactive_text='󰍹',
                   **widget_defaults)

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
            background="#282828ff",
            margin=[10,10,0,10],
            border_width=[0,0,0,0],
            border_color="#dfbf8eff"), ),
  
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
            background="#282828ff",
            margin=[10,10,0,10],
            border_width=[0,0,0,0],
            border_color="#dfbf8eff"), ),  

]

cursor_warp = True

floating_layout = layout.Floating(**layout_theme)


# wmname = "LG3D"
wmname = "Qtile"
  

  
