# NixOS workstation SwayFX configs

{ config, pkgs, ... }:

# SwayFX config variables
let
  mod = "Mod4";
  terminal = "alacritty";
  file_manager = "pcmanfm";
  webbrowser = "firefox";
in 

# Define SwayFX workspace names
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

{

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = false;
    package = "${pkgs.swayfx}";
    config = {
      # Font settings
      fonts = {
        names = [ "Ubuntu Nerd Font" ];
        style = "Medium";
        size = 11.0;
      };

      # Cursor theme and size
      seat = {
        "0" = {
          xcursor_theme = "phinger-cursors-light 24";
        };
      };
 
      # Window settings
      window = {
        border = 4;
        titlebar = false;
      };

      floating = {
        border = 4;
        titlebar = false;
      };

      gaps = {
        inner = 10;
        top = 0;
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
      
      # Output settings (wallpaper/monitors)
      output = {
        "*" = {
          bg = "~/Pictures/sway/background.jpg fill";
        };

        DP-1 = {
          resolution = "3440x1440@164.999Hz";
          position = "0,1080";
          adaptive_sync = "off";
        };

        DP-2 = {
          resolution = "2560x1080@74.991Hz";
          position = "0,0";
        };
      };

      # Autostart
      startup = [
        { command = "~/.config/sway/autostart.sh"; }
      ];

      # Keybindings
      keybindings = {
        # open a terminal
        "${mod}+t" = "exec ${terminal}";

        # open a file manager
        "${mod}+f" = "exec ${file_manager}";

        # open terminal file manager 
        "${mod}+y" = "exec ${terminal} -e yazi";

        # open a webbrowser
        "${mod}+w" = "exec ${webbrowser}";

        # open pavucontrol
        "${mod}+p" = "exec pavucontrol";

        # restore alsa sound settings
        "${mod}+a" = "exec alsactl --file ~/.config/asound.state restore";

        # open Deezer in a firefox window
        "${mod}+d" = "exec ${webbrowser} -new-window https://www.deezer.com/en/";

        # open application launcher
        "${mod}+space" = "exec wofi";

        # open powermenu
        "${mod}+Escape" = "exec ~/.config/sway/wofi-powermenu.sh";

        # Mako notification history and close all notifications
        "${mod}+n" = "exec makoctl restore";
        "${mod}+c" = "exec makoctl dismiss --all";

        # play/pause/previous/next keyboard controls
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";

        # reload sway config and exit sway
        "${mod}+Control+r" = "reload";
        "${mod}+Control+q" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";

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

        # enable/disable adaptive sync with keybinds
        "${mod}+Control+a" = "exec sway output DP-1 adaptive_sync on";
        "${mod}+Control+v" = "exec sway output DP-1 adaptive_sync off";

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

      # drag floating windows and resize them with the mouse
      floating.modifier = "${mod}";

      # bind workspaces to monitors
      workspaceOutputAssign = [
        { output = "DP-1"; workspace = "${ws1}"; }
        { output = "DP-1"; workspace = "${ws2}"; }
        { output = "DP-1"; workspace = "${ws3}"; }
        { output = "DP-1"; workspace = "${ws4}"; }
        { output = "DP-1"; workspace = "${ws5}"; }
        { output = "DP-1"; workspace = "${ws6}"; }
        { output = "DP-1"; workspace = "${ws7}"; }
        { output = "DP-2"; workspace = "${ws8}"; }
      ];

      # whether mouse should follow output, container, or not follow
      focus.mouseWarping = "container";
     
      bars = [ ];
    };

    # SwayFX-specific settings
    extraConfig = ''
      # corner radius
      corner_radius 10

      # window background blur
      blur off
      blur_xray off
      blur_passes 2
      blur_radius 5

      # shadows
      shadows off
      shadows_on_csd off
      shadow_blur_radius 20
      shadow_color #0000007F

      # dim inactive windows. 0.0 = no dimming, 1.0 = fully dimmed
      default_dim_inactive 0.0
      dim_inactive_colors.unfocused #000000FF
      dim_inactive_colors.urgent #900000FF
    '';
  };

  # Autostart script
  xdg.configFile = {
    "sway/autostart.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env bash

        autotiling --splitratio 1.61 --limit 2 &
        waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style.css &
        mako &
        playerctld daemon &
        lxsession &
        liquidctl initialize all &
        sleep 2
        liquidctl --match kraken set pump speed 100 &
        ~/repos/configs/Scripts/yoda --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl &
        nm-applet &
        openrgb &
        xrandr --output DP-1 --primary &
        alsactl --file ~/.config/asound.state restore &
      '';
    };

    # Wofi powermenu script
    "sway/wofi-powermenu.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env bash

        op=$( echo -e " Poweroff\n Reboot\n󰒲 Suspend\n Lock\n󰗽 Logout" | wofi --show dmenu --width 10% | awk '{print tolower($2)}' )

        case $op in
            poweroff)
                    ;&
            reboot)
                    ;&
            suspend)
                    systemctl $op
                    ;;
            lock)
                    swaylock
                    ;;
            logout)
                    sway exit
                    ;;
        esac
      '';
    };
  };
}
