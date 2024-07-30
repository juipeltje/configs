# NixOS workstation greeter configuration

{ config, pkgs, ... }:

# SwayFX configuration for greeter
let
  SwayFXConfig = pkgs.writeText "greetd-swayfx-config" ''
    ## appearance
    # cursor theme and size
    seat seat0 xcursor_theme "phinger-cursors-light" 24

    ## start regreet
    exec "${pkgs.greetd.regreet}/bin/regreet; swaymsg exit"

    # set resolution/refreshrate
    output DP-1 resolution 3440x1440@164.999Hz position 0,1080 adaptive_sync off
    output DP-2 disable
    #output DP-2 resolution 2560x1080@74.991Hz position 0,0

    include /etc/sway/config.d/\*
  '';
in

{

  # Enable greetd and ReGreet, and greetd/ReGreet configuration.
  services.greetd = {
    enable = true;
    vt = 1;
    settings = {
      default_session = {
        command = "${pkgs.swayfx}/bin/sway --config ${SwayFXConfig}";
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
