# NixOS workstation i3 configs

{ config, pkgs, ... }:

# i3 config variables
let
  mod = "Mod4";
  terminal = "alacritty";
  file_manager = "pcmanfm";
  webbrowser = "firefox";
in

# Define i3 workspace names
let
  ws1 = "1";
  ws2 = "2";
  ws3 = "3";
  ws4 = "4";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
in

# Define i3 monitor names
let
  DP-0 = "DisplayPort-0";
  DP-1 = "DisplayPort-1";
in

{

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      # Font settings
      fonts = { 
        names = [ "Ubuntu Nerd Font" ];
        style = "Medium";
        size = 11.0;
      };
 
      # Window settings
      window = { 
        border = 4;
        titlebar = false;
      };

      floating.border = 4;
      gaps = {
        inner = 10;
        top = 48;
      };

      # Color themes
      # Tokyo-Night
      colors = {
        focused = {
          border = "#a9b1d6";
          background = "#a9b1d6";
          text = "#a9b1d6";
          indicator = "#a9b1d6";
          childBorder = "#a9b1d6";
        };
      
        focusedInactive = {
          border = "#565f89";
          background = "#565f89";
          text = "#565f89";
          indicator = "#565f89";
          childBorder ="#565f89";
        };

        unfocused = {
          border = "#565f89";
          background = "#565f89";
          text = "#565f89";
          indicator = "#565f89";
          childBorder = "#565f89";
        };

        urgent = {
          border = "#f7768e";
          background = "#f7768e";
          text = "#f7768e";
          indicator = "#f7768e";
          childBorder = "#f7768e";
        };
  
        placeholder = {
          border = "#565f89";
          background = "#565f89";
          text = "#565f89";
          indicator = "#565f89";
          childBorder = "#565f89";
        };
      };
      
      # Autostart
      startup = [
        { command = "~/.config/polybar/launch.sh"; always = true; notification = false; }
        { command = "~/.config/i3/autostart.sh"; notification = false; }
      ]; 
     
      # Keybindings
      keybindings = {
        # Open a terminal
        "${mod}+t" = "exec ${terminal}";

        # open a file manager
        "${mod}+f" = "exec ${file_manager}";

        # open a webbrowser
        "${mod}+w" = "exec ${webbrowser}";

        # open pavucontrol
        "${mod}+a" = "exec pavucontrol";

        # open Deezer in a firefox window
        "${mod}+d" = "exec ${webbrowser} -new-window https://www.deezer.com/en/";

        # open rofi application launcher
        "${mod}+space" = "exec rofi -show drun -show-icons -icon-theme Papirus-Dark";

        # open rofi powermenu
        "${mod}+Escape" = "exec ~/.config/i3/rofi-powermenu.sh";

        # Dunst notification history and close all notifications
        "${mod}+n" = "exec dunstctl history-pop";
        "${mod}+c" = "exec dunstctl close-all";

        # play/pause/previous/next keyboard controls
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";

        # reload i3 config and exit i3
        "${mod}+Control+r" = "reload";
        "${mod}+Control+q" = "exec i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'";

        # kill a window
        "${mod}+q" = "kill";

        # switch focused window
        "${mod}+Right" = "focus right";
        "${mod}+Left" = "focus left";
        "${mod}+Up" = "focus up";
        "${mod}+Down" = "focus down";

        # toggle floating window
        "${mod}+Shift+space" = "floating toggle";

        # toggle fullscreen
        "${mod}+Shift+f" = "fullscreen";

        # move the focused window
        "${mod}+Control+Right" = "move right";
        "${mod}+Control+Left" = "move left";
        "${mod}+Control+Up" = "move up";
        "${mod}+Control+Down" = "move down";

        # Resize windows
        "${mod}+Shift+Right" = "resize grow width 50px";
        "${mod}+Shift+Left" = "resize shrink width 50px";
        "${mod}+Shift+Up" = "resize shrink height 50px";
        "${mod}+Shift+Down" = "resize grow height 50px";

        # send window to scratchpad and toggle scratchpad
        "${mod}+Shift+s" = "move scratchpad";
        "${mod}+s" = "scratchpad show";
         
        # switch to workspaces
        "${mod}+KP_End" = "workspace number ${ws1}";
        "${mod}+KP_Down" = "workspace number ${ws2}";
        "${mod}+KP_Next" = "workspace number ${ws3}";
        "${mod}+KP_Left" = "workspace number ${ws4}";
        "${mod}+KP_Begin" = "workspace number ${ws5}";
        "${mod}+KP_Right" = "workspace number ${ws6}";
        "${mod}+KP_Home" = "workspace number ${ws7}";
        "${mod}+KP_Up" = "workspace number ${ws8}";

        # move window to workspace
        "${mod}+Shift+KP_End" = "move container to workspace number ${ws1}";
        "${mod}+Shift+KP_Down" = "move container to workspace number ${ws2}";
        "${mod}+Shift+KP_Next" = "move container to workspace number ${ws3}";
        "${mod}+Shift+KP_Left" = "move container to workspace number ${ws4}";
        "${mod}+Shift+KP_Begin" = "move container to workspace number ${ws5}";
        "${mod}+Shift+KP_Right" = "move container to workspace number ${ws6}";
        "${mod}+Shift+KP_Home" = "move container to workspace number ${ws7}";
        "${mod}+Shift+KP_Up" = "move container to workspace number ${ws8}";

        # choose how the windows will be split when opening a new window
        "${mod}+h" = "splith";
        "${mod}+v" = "splitv";

        # switch between the different layout styles
        "${mod}+Control+s" = "layout stacking";
        "${mod}+Control+w" = "layout tabbed";
        "${mod}+Control+e" = "layout toggle split";
      };

      # Drag floating windows and resize them with the mouse
      floating.modifier = "${mod}";

      # bind workspaces to monitors
      workspaceOutputAssign = [
        { output = "${DP-1}"; workspace = "${ws1}"; }
        { output = "${DP-0}"; workspace = "${ws2}"; }
        { output = "${DP-0}"; workspace = "${ws3}"; }
        { output = "${DP-0}"; workspace = "${ws4}"; }
        { output = "${DP-0}"; workspace = "${ws5}"; }
        { output = "${DP-0}"; workspace = "${ws6}"; }
        { output = "${DP-0}"; workspace = "${ws7}"; }
        { output = "${DP-0}"; workspace = "${ws8}"; } 
      ];
      
      bars = [ ];
    };
  };

  # Autostart script
  xdg.configFile = {
    "i3/autostart.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env bash

        autotiling --splitratio 1.61 --limit 2 &
        sleep 1
        xrandr --output DisplayPort-0 --primary --mode 3440x1440 --rate 165.00 --output DisplayPort-1 --mode 2560x1080 --rate 74.99 --above DisplayPort-0 &
        ~/.fehbg &
        dunst &
        playerctld daemon &
        lxsession &
        liquidctl initialize all &
        sleep 2
        liquidctl --match kraken set pump speed 100 &
        ~/repos/configs/Scripts/yoda --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl &
        xset s off -dpms &
        nm-applet &
        openrgb &
      '';
    };
    
    # Rofi powermenu script
    "i3/rofi-powermenu.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env bash

        op=$( echo -e " Poweroff\n Reboot\n󰒲 Suspend\n Lock\n󰗽 Logout" | rofi -dmenu -theme-str 'window {width: 10%;}' | awk '{print tolower($2)}' )

        case $op in
                poweroff)
                        ;&
                reboot)
                        ;&
                suspend)
                        loginctl $op
                        ;;
                lock)
                        i3-lock
                        ;;
                logout)
                        i3-msg exit
                        ;;
        esac
      '';
    };
  };
}
