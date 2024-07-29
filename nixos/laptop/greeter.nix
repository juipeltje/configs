# NixOS laptop greeter configuration

{ config, pkgs, ... }:

# Hyprland configuration for greeter
let
  HyprlandConfig = pkgs.writeText "greetd-hyprland-config" ''
    # Hyprland greeter config

    # monitor settings
    monitor=eDP-1,1920x1080@60,0x0,1
    
    # Execute your favorite apps at launch
    exec-once = ${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit

    # Env variables/set cursor size
    env = XCURSOR_SIZE,24

    input {
      follow_mouse = 1
      sensitivity = 0
      touchpad {
        tap-to-click = true
      }
    }

    misc {
      disable_hyprland_logo = true
      disable_splash_rendering = true
      force_default_wallpaper = 0
    }
  '';
in

{

  # Enable greetd and ReGreet, and greetd/ReGreet configuration.
  services.greetd = {
    enable = true;
    vt = 1;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland --config ${HyprlandConfig}";
        user = "greeter";
      };
    };
  };

  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = /greeter-background/background.jpg;
        fit = "Contain";
      };

      GTK = {
        application_prefer_dark_theme = false;
        cursor_theme_name = "phinger-cursors-light";
        font_name = "Ubuntu Nerd Font Medium 12";
        icon_theme_name = "Mint-Y-Sand";
        theme_name = "Tokyonight-Dark-BL";
      };

      commands = {
        reboot = [ "systemctl" "reboot" ];
        poweroff = [ "systemctl" "poweroff" ];
      };
    };
  };
}
