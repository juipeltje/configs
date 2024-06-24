# Qtile config

# Import libraries
from libqtile.lazy import lazy
from libqtile.config import Key, Drag, Group, ScratchPad, DropDown
from libqtile import layout
import os
import colors

# Variables
home = os.path.expanduser('~')
mod = "mod4"
terminal = "kitty"
webbrowser = "firefox"
file_manager = "pcmanfm"

# Keybindings
keys = [

  # Open a terminal
  Key([mod], "t", lazy.spawn(terminal) ),

  # Open a file manager
  Key([mod], "f", lazy.spawn(file_manager) ),

  # Open a terminal file manager
  Key([mod], "y", lazy.spawn(terminal + " -e yazi") ),

  # Open a webbrowser
  Key([mod], "w", lazy.spawn(webbrowser) ),

  # Open pavucontrol
  Key([mod], "a", lazy.spawn("pavucontrol") ),

  # Open Deezer in firefox tab
  Key([mod], "d", lazy.spawn(webbrowser + " -new-window https://www.deezer.com/en/") ),

  # open Rofi application launcher, powermenu, and theme-switcher
  Key([mod], "space", lazy.spawn("rofi -show drun") ),
  Key([mod], "Escape", lazy.spawn(home + '/.config/qtile/rofi-powermenu.sh') ),
  Key([mod, "shift"], "t", lazy.spawn(home + '/.config/qtile/rofi-theme-switcher.sh') ),

  # Dunst notification history and close all notifications
  Key([mod], "n", lazy.spawn("dunstctl history-pop") ),
  Key([mod], "c", lazy.spawn("dunstctl close-all") ),

  # play/pause/previous/next keyboard controls
  Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause") ),
  Key([], "XF86AudioNext", lazy.spawn("playerctl next") ),
  Key([], "XF86AudioPrev", lazy.spawn("playerctl previous") ),

  # Start/stop picom keybindings for playing games
  Key([mod], "g", lazy.spawn(home + '/repos/configs/scripts/start-gamemode.sh') ),
  Key([mod], "p", lazy.spawn(home + '/repos/configs/scripts/stop-gamemode.sh') ),

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

mouse = [

  # Dragging and resizing floating windows with mod + mouse buttons
  Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position() ),
  Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size() ),

]

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

for i in groups:
  keys.extend(
    [

      # mod + number of group = switch to group
      Key([mod], i.name, lazy.group[i.name].toscreen() ),

      # switch between groups using the numpad
      Key([mod], "KP_End", lazy.group["1"].toscreen() ),
      Key([mod], "KP_Down", lazy.group["2"].toscreen() ),
      Key([mod], "KP_Next", lazy.group["3"].toscreen() ),
      Key([mod], "KP_Left", lazy.group["4"].toscreen() ),
      Key([mod], "KP_Begin", lazy.group["5"].toscreen() ),
      Key([mod], "KP_Right", lazy.group["6"].toscreen() ),
      Key([mod], "KP_Home", lazy.group["7"].toscreen() ),
      Key([mod], "KP_Up", lazy.group["8"].toscreen() ),


      # mod + shift + number of group = switch to & move focused window to group
      # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True) ),

      # switch to and move focused window to group using the numpad
      # Key([mod, "shift"], "KP_End", lazy.window.togroup("1", switch_group=True) ),
      # Key([mod, "shift"], "KP_Down", lazy.window.togroup("2", switch_group=True) ),
      # Key([mod, "shift"], "KP_Next", lazy.window.togroup("3", switch_group=True) ),
      # Key([mod, "shift"], "KP_Left", lazy.window.togroup("4", switch_group=True) ),
      # Key([mod, "shift"], "KP_Begin", lazy.window.togroup("5", switch_group=True) ),
      # Key([mod, "shift"], "KP_Right", lazy.window.togroup("6", switch_group=True) ),
      # Key([mod, "shift"], "KP_Home", lazy.window.togroup("7", switch_group=True) ),
      # Key([mod, "shift"], "KP_Up", lazy.window.togroup("8", switch_group=True) ),

      # use this if you don't want to switch to the group that the window was moved to
      Key([mod, "shift"], i.name, lazy.window.togroup(i.name) ),

      # use this if you don't want to switch to the group that the window was moved to with the numpad
      Key([mod, "shift"], "KP_End", lazy.window.togroup("1") ),
      Key([mod, "shift"], "KP_Down", lazy.window.togroup("2") ),
      Key([mod, "shift"], "KP_Next", lazy.window.togroup("3") ),
      Key([mod, "shift"], "KP_Left", lazy.window.togroup("4") ),
      Key([mod, "shift"], "KP_Begin", lazy.window.togroup("5") ),
      Key([mod, "shift"], "KP_Right", lazy.window.togroup("6") ),
      Key([mod, "shift"], "KP_Home", lazy.window.togroup("7") ),
      Key([mod, "shift"], "KP_Up", lazy.window.togroup("8") ),

  ]
)

# Scratchpad window settings
groups.append(ScratchPad("0", [ DropDown("term", terminal, opacity=1, width=0.4, height=0.6, x=0.3, y=0.2, on_focus_lost_hide=False), ]),

)

# set colorscheme
colors = colors.GruvboxMaterialDark

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
wmname = "Qtile"
