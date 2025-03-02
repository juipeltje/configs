# Qtile config

# Import libraries
from libqtile.lazy import lazy
from libqtile.config import Key, Drag, Group, ScratchPad, DropDown
from libqtile import layout, qtile, hook
from libqtile.backend.wayland import InputConfig
import os
import subprocess
import colors

# Variables
home = os.path.expanduser('~')
mod = "mod4"
terminal = "kitty"
webbrowser = "firefox"

# autostart programs when starting window manager
@hook.subscribe.startup_once
def autostart():
  if qtile.core.name == "x11":
    autostart = "/.config/qtile/autostart.sh"

  elif qtile.core.name == "wayland":
    autostart = "/.config/qtile/autostart-wayland.sh"

  subprocess.Popen([home + autostart])

# Keybindings
keys = [
  # Open a terminal
  Key([mod], "t", lazy.spawn(terminal) ),

  # Open file manager
  Key([mod], "f", lazy.spawn(terminal + " -e yazi") ),

  # Open a webbrowser
  Key([mod], "w", lazy.spawn(webbrowser) ),

  # Open pavucontrol
  Key([mod], "a", lazy.spawn("pavucontrol") ),

  # Open Deezer in firefox tab
  Key([mod], "d", lazy.spawn(webbrowser + " -new-window https://www.deezer.com/en/") ),

  # play/pause/previous/next keyboard controls
  Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause") ),
  Key([], "XF86AudioNext", lazy.spawn("playerctl next") ),
  Key([], "XF86AudioPrev", lazy.spawn("playerctl previous") ),

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
  Key([mod], "KP_Add", lazy.layout.grow() ),
  Key([mod], "KP_Subtract", lazy.layout.shrink() ),
  Key([mod], "KP_Enter", lazy.layout.reset() ),

  # Toggle between the different layouts
  Key([mod], "l", lazy.next_layout() ),

  # Go to next/previous group
  Key([mod, "control"], "Right", lazy.screen.next_group() ),
  Key([mod, "control"], "Left", lazy.screen.prev_group() ),

  # Toggle Scratchpad
  Key([mod], "s", lazy.group['0'].dropdown_toggle('term') ),
]

if qtile.core.name == "x11":
  keys.extend(
    [
      # open application launcher
      Key([mod], "space", lazy.spawn("rofi -show drun") ),

      # open theme switcher
      Key([mod, "shift"], "t", lazy.spawn(home + '/.config/qtile/rofi-theme-switcher.sh') ),

      # open powermenu
      Key([mod], "Escape", lazy.spawn(home + '/repos/configs/scripts/dmenu/rofi-powermenu.sh') ),

      # notification history and close all notifications
      Key([mod], "n", lazy.spawn("dunstctl history-pop") ),
      Key([mod], "c", lazy.spawn("dunstctl close-all") ),

      # Start/stop picom keybindings for playing games
      Key([mod], "g", lazy.spawn(home + '/repos/configs/scripts/start-gamemode.sh') ),
      Key([mod], "p", lazy.spawn(home + '/repos/configs/scripts/stop-gamemode.sh') ),
    ]
  )

elif qtile.core.name == "wayland":
  keys.extend(
    [
      # open application launcher
      Key([mod], "space", lazy.spawn("fuzzel") ),

      # open theme switcher
      Key([mod, "shift"], "t", lazy.spawn(home + '/repos/configs/scripts/dmenu/fuzzel-theme-switcher.sh') ),

      # open powermenu
      Key([mod], "Escape", lazy.spawn(home + '/repos/configs/scripts/dmenu/fuzzel-powermenu.sh') ),

      # open compositor switcher
      Key([mod, "shift"], "c", lazy.spawn(home + '/repos/configs/scripts/dmenu/fuzzel-compositor-switcher.sh') ),

      # notification history and close all notifications
      Key([mod], "n", lazy.spawn("makoctl restore") ),
      Key([mod], "c", lazy.spawn("makoctl dismiss --all") ),
    ]
  )

mouse = [
  # Dragging and resizing floating windows with mod + mouse buttons
  Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position() ),
  Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size() ),
]

if qtile.core.name == "x11":
  groups = [
    Group("1", layout="monadtall", label="  1", screen_affinity=0 ),
    Group("2", layout="monadtall", label="  2", screen_affinity=0 ),
    Group("3", layout="monadtall", label="  3", screen_affinity=0 ),
    Group("4", layout="monadtall", label="  4", screen_affinity=0 ),
    Group("5", layout="monadtall", label="  5", screen_affinity=0 ),
    Group("6", layout="monadtall", label="  6", screen_affinity=0 ),
    Group("7", layout="monadtall", label="  7", screen_affinity=0 ),
    Group("8", layout="monadtall", label="  8", screen_affinity=1 ),
  ]

  numpad_keys = [ 'KP_End', 'KP_Down', 'KP_Next', 'KP_Left', 'KP_Begin', 'KP_Right', 'KP_Home', 'KP_Up' ]

  for i, numpad_key in zip (groups, numpad_keys):
    keys.extend(
      [
        # mod + number of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen() ),

        # move window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name) ),

        # switch between groups using the numpad
        Key([mod], numpad_key, lazy.group[i.name].toscreen() ),

        # move windows to group using the numpad
        Key([mod, "shift"], numpad_key, lazy.window.togroup(i.name) ),
      ]
    )

  # Scratchpad window settings
  groups.append(ScratchPad("0", [ DropDown("term", terminal + " --name scratchpad", opacity=1, width=0.4, height=0.6, x=0.3, y=0.2, on_focus_lost_hide=False), ]), )

elif qtile.core.name == "wayland":
  groups = [
    Group("1", layout="monadtall", label="  1", screen_affinity=1 ),
    Group("2", layout="monadtall", label="  2", screen_affinity=1 ),
    Group("3", layout="monadtall", label="  3", screen_affinity=1 ),
    Group("4", layout="monadtall", label="  4", screen_affinity=1 ),
    Group("5", layout="monadtall", label="  5", screen_affinity=1 ),
    Group("6", layout="monadtall", label="  6", screen_affinity=1 ),
    Group("7", layout="monadtall", label="  7", screen_affinity=1 ),
    Group("8", layout="monadtall", label="  8", screen_affinity=0 ),
  ]

  numpad_keys = [ 'KP_End', 'KP_Down', 'KP_Next', 'KP_Left', 'KP_Begin', 'KP_Right', 'KP_Home', 'KP_Up' ]

  for i, numpad_key in zip (groups, numpad_keys):
    keys.extend(
      [
        # mod + number of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen() ),

        # move window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name) ),

        # switch between groups using the numpad
        Key([mod], numpad_key, lazy.group[i.name].toscreen() ),

        # move windows to group using the numpad
        Key([mod, "shift"], numpad_key, lazy.window.togroup(i.name) ),
      ]
    )

  # Scratchpad window settings
  groups.append(ScratchPad("0", [ DropDown("term", terminal + " --name scratchpad", opacity=1, width=0.4, height=0.6, x=0.3, y=0.2, on_focus_lost_hide=False), ]), )

# set colorscheme
colors = colors.Nordic

layout_theme = {
                "border_focus":colors[0],
                "border_normal":colors[2],
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
      Key(["control", "mod1"], f"f{vt}", lazy.core.change_vt(vt) ),
    )
