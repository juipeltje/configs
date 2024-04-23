# NixOS workstation Hyprland configs

{ config, pkgs, ... }:

# Hyprland config variables
let
  Mod = "SUPER";
  terminal = "alacritty";
  file_manager = "pcmanfm";
  webbrowser = "firefox";
in

{

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      # Monitor settings
      monitor = [
        "DP-1,3440x1440@165,0x1080,1"
        "DP-2,2560x1080@75,0x0,1"
      ];

      # Autostart programs
      exec-once = [ "~/.config/hypr/autostart.sh" ];

      # Env variables/set cursor size
      env = [ "XCURSOR_SIZE,24" ];

      # Input settings
      input = {
        follow_mouse = 1;
        float_switch_override_focus = 2;
        sensitivity = 0;
      };

      # General settings
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 4;

        # color themes
        
        # Gruvbox-Material
        # col.active_border = rgb(dfbf8e)
        # col.inactive_border = rgb(665c54)
        
        # Nordic
        # col.active_border = rgb(8fbcbb)
        # col.inactive_border = rgb(4c566a)
        
        # Tokyo-Night
        "col.active_border" = "rgb(a9b1d6)";
        "col.inactive_border" = "rgb(565f89)";

        layout = "master";
      };

      # Decoration settings
      decoration = {
        rounding = 10;
        drop_shadow = false;
        shadow_range = 4;
        "col.shadow" = "rgba(1a1a1aee)";
        dim_special = 1.0;
        blur = {
          enabled = false;
        };
      };

      # Animation settings
      animations = {
        enabled = true;
        first_launch_animation = true;
        bezier = "fast&tight, 0.79, 0.33, 0.14, 0.53";
        animation = [ 
          # Windows: styles: slide, popin
          "windows, 1, 2, fast&tight, popin 10%"
          "windowsIn, 1, 2, fast&tight, popin 10%"
          "windowsOut, 1, 2, fast&tight, popin 10%"
          "windowsMove, 1, 2, fast&tight, slide"
          
          "fade, 0, 2, fast&tight"
          "fadeIn, 1, 2, fast&tight"
          "fadeOut, 1, 2, fast&tight"
          "fadeSwitch, 0, 2, fast&tight"
          "fadeShadow, 0, 2, fast&tight"
          "fadeDim, 0, 2, fast&tight"
          
          "border, 1, 2, fast&tight"
          
          # Borderangle: styles: once, loop
          "borderangle, 0, 2, fast&tight, once"
          
          # Workspaces: styles: slide, slidevert, fade, slidefade, slidefadevert
          "workspaces, 1, 2, fast&tight, slide"
          "specialWorkspace, 1, 2, fast&tight, slidevert"
        ];
      };

      # Miscellaneous settings
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        
        # VRR: 0 = off, 1 = on, 2 = fullscreen only
        vrr = 2;
        
        animate_manual_resizes = true;
        focus_on_activate = false;
        allow_session_lock_restore = false;
        close_special_on_empty = true;
      };

      # Master/stack layout settings
      master = {
        special_scale_factor = 0.5;
        mfact = 0.5;
        new_is_master = false;
        new_on_top = false;
        orientation = "left";
        inherit_fullscreen = false;
        smart_resizing = false;
      };

      # Dwindle layout settings
      dwindle = {
        force_split = 2;
        smart_resizing = false;
        special_scale_factor = 0.5;
      };
      
      # Keybindings
      bind = [
        # open a terminal
        "${Mod}, T, exec, ${terminal}"

        # open a file manager
        "${Mod}, F, exec, ${file_manager}"

        # open terminal file manager
        "${Mod}, R, exec, ${terminal} -e yazi"

        # open a webbrowser
        "${Mod}, W, exec, ${webbrowser}"

        # open pavucontrol
        "${Mod}, A, exec, pavucontrol"

        # open Deezer in a firefox window
        "${Mod}, D, exec, ${webbrowser} -new-window https://www.deezer.com/en/"

        # open wofi application launcher
        "${Mod}, SPACE, exec, wofi"

        # open wofi powermenu
        "${Mod}, escape, exec, ~/.config/hypr/wofi-powermenu.sh"

        # Mako notification history and close all notifications
        "${Mod}, N, exec, makoctl restore"
        "${Mod}, C, exec, makoctl dismiss --all"

        # play/pause/previous/next keyboard controls
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        # reload the hyprland config and exit hyprland
        "${Mod} CONTROL, R, exec, hyprctl reload"
        "${Mod} CONTROL, Q, exit"

        # kill apps by clicking on them using hyprctl
        "${Mod} CONTROL, K, exec, hyprctl kill"

        # kill a window
        "${Mod}, Q, killactive"

        # switch focused window
        "${Mod}, right, movefocus, r"
        "${Mod}, left, movefocus, l"
        "${Mod}, up, movefocus, u"
        "${Mod}, down, movefocus, d"

        # toggle floating window
        "${Mod} SHIFT, SPACE, togglefloating"

        # toggle fullscreen
        "${Mod} SHIFT, F, fullscreen, 0"

        # move windows between left/right columns or move up/down in current stack
        "${Mod} CONTROL, right, swapwindow, r"
        "${Mod} CONTROL, left, swapwindow, l"
        "${Mod} CONTROL, up, swapwindow, u"
        "${Mod} CONTROL, down, swapwindow, d"

        # grow/shrink windows in layout and reset
        "${Mod} SHIFT, right, resizeactive, 50 0"
        "${Mod} SHIFT, left, resizeactive, -50 0"
        "${Mod} SHIFT, up, resizeactive, 0 -50"
        "${Mod} SHIFT, down, resizeactive, 0 50"
        # bind = $mainMod SHIFT, return, resizeactive, exact 50% 50%

        # toggle scratchpad and turn window into a scratchpad
        "${Mod}, S, togglespecialworkspace, scratchpad"
        "${Mod} SHIFT, S, movetoworkspace, special:scratchpad"

        # switch between workspaces using the numpad
        "${Mod}, KP_End, workspace, 1"
        "${Mod}, KP_Down, workspace, 2"
        "${Mod}, KP_Next, workspace, 3"
        "${Mod}, KP_Left, workspace, 4"
        "${Mod}, KP_Begin, workspace, 5"
        "${Mod}, KP_Right, workspace, 6"
        "${Mod}, KP_Home, workspace, 7"
        "${Mod}, KP_Up, workspace, 8"

        # move active window to workspace using the numpad
        "${Mod} SHIFT, KP_End, movetoworkspacesilent, 1"
        "${Mod} SHIFT, KP_Down, movetoworkspacesilent, 2"
        "${Mod} SHIFT, KP_Next, movetoworkspacesilent, 3"
        "${Mod} SHIFT, KP_Left, movetoworkspacesilent, 4"
        "${Mod} SHIFT, KP_Begin, movetoworkspacesilent, 5"
        "${Mod} SHIFT, KP_Right, movetoworkspacesilent, 6"
        "${Mod} SHIFT, KP_Home, movetoworkspacesilent, 7"
        "${Mod} SHIFT, KP_Up, movetoworkspacesilent, 8"
      ];

      bindm = [
        # dragging and resizing windows with mod + mouse buttons
        "${Mod}, mouse:272, movewindow"
        "${Mod}, mouse:273, resizewindow"
      ];

      # Workspace rules/bind workspaces to monitors
      workspace = [
        "1, monitor:DP-2"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-1"
        "7, monitor:DP-1"
        "8, monitor:DP-1"
        "special:scratchpad, on-created-empty:${terminal}"
      ];
    };
  };

  # Autostart script
  xdg.configFile = {
    "hypr/autostart.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env bash

        hyprpaper &
        waybar -c ~/.config/waybar/hyprland-config -s ~/.config/waybar/hyprland-style.css &
        hyprctl setcursor phinger-cursors-light 24 &
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

    # Hyprpaper
    "hypr/hyprpaper.conf" = {
      enable = true;
      text = ''
        preload = /home/joppe/Pictures/Wallpapers/hyprland/wall2.png
        wallpaper = DP-1,/home/joppe/Pictures/Wallpapers/hyprland/wall2.png
        wallpaper = DP-2,/home/joppe/Pictures/Wallpapers/hyprland/wall2.png
      '';
    };
    
    # Wofi powermenu script
    "hypr/wofi-powermenu.sh" = {
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
                        hyprctl dispatch exit
                        ;;
        esac
      '';
    };
  };
}
