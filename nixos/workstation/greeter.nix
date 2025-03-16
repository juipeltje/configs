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
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };

    font = {
      size = 12;
      name = "Ubuntu Nerd Font Medium";
      package = (pkgs.nerdfonts.override { fonts = [ "Ubuntu" ]; });
    };

    cursorTheme = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
    };

    iconTheme = {
      name = "Mint-Y-Sand";
      package = pkgs.mint-y-icons;
    };
    
    settings = {
      background = {
        path = ./../../workstation/wallpapers/WallpaperDog-10730444.jpg;
        fit = "Contain";
      };

      GTK = {
        application_prefer_dark_theme = false;
      };

      commands = {
        reboot = [ "systemctl" "reboot" ];
        poweroff = [ "systemctl" "poweroff" ];
      };
    };
  };
}
