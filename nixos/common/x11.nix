# NixOS X11 configuration

{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      # Enable the X11 windowing system, configure X11 keymap, X11 window managers, Kodi, and Picom.
      services = {
        xserver = {
          enable = true;
          xkb.layout = "us";
          xkb.variant = "";
          excludePackages = [ pkgs.xterm ];
          videoDrivers = [ "amdgpu" ];
          windowManager = {
            i3.enable = true;
            i3.extraPackages = [ ];
            qtile.enable = true;
            qtile.extraPackages = python3Packages: with python3Packages; [ qtile-extras ];
          };

          displayManager = {
            startx.enable = true;
          };

          desktopManager = {
            kodi.enable = true;
            kodi.package = pkgs.kodi;
          };
        };

        # Configure laptop touchpad.
        libinput.touchpad.additionalOptions = lib.mkIf (config.networking.hostName == "NixOS-Lappie") ''
          Option "Tapping" "on"
        ''; 
      };

      # Additional xorg-specific packages
      environment.systemPackages = with pkgs; [
        # Bar
        polybarFull

        # Compositor
        picom

        # Notifications
        dunst

        # Run launcher
        rofi

        # Other tools 
        xdotool
        xorg.xhost
      ];

      # Systemd service for Picom, xrandr, xset, and setting up Systemd target for Qtile.
      systemd.user = {
        services = {
          picom = {
            enable = true;
            unitConfig = {
              Description = "Picom composite manager";
              PartOf = [ "qtile-session.target" ];
            };

            serviceConfig = {
              ExecStart = "${pkgs.picom}/bin/picom";
              Restart = "on-failure";
            };

            wantedBy = [ "qtile-session.target" ];
          };

          xrandr = {
            enable = true;
            unitConfig = {
              Description = "Set resolution and refreshrate with xrandr";
              Type = "oneshot";
              PartOf = [ "qtile-session.target" ];
            };

            serviceConfig = {
              Restart = "on-failure";
            };

            wantedBy = [ "qtile-session.target" ];
          }; 

          xset = {
            enable = true;
            unitConfig = {
              Description = "Run xset command on login";
              Type = "oneshot";
              PartOf = [ "qtile-session.target" ];
            };

            serviceConfig = {
              ExecStart = "${pkgs.xorg.xset}/bin/xset s off -dpms";
              Restart = "on-failure";
            };

            wantedBy = [ "qtile-session.target" ];
          };
        };

        targets = {
          qtile-session = {
            description = "Qtile session";
            documentation = [ "man:systemd.special(7)" ];
            bindsTo = [ "graphical-session.target" ];
            wants = [ "graphical-session-pre.target" ];
            after = [ "graphical-session-pre.target" ];
          };
        };
      };
    }

    (lib.mkIf (config.networking.hostName == "NixOS-Rig") {
      services.xserver.deviceSection = ''
        Option "TearFree" "true"
        Option "VariableRefresh" "true"
        Option "DRI" "3"
      '';

      systemd.user.services.xrandr.serviceConfig.ExecStart =
        "${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-0 --primary --mode 3440x1440 --rate 165.00 --output DisplayPort-1 --mode 2560x1080 --rate 74.99 --above DisplayPort-0";
    })

    (lib.mkIf (config.networking.hostName == "NixOS-Lappie") {
      services.xserver.deviceSection = ''
        Option "TearFree" "true"
        Option "DRI" "3"
      '';

      systemd.user.services.xrandr.serviceConfig.ExecStart = 
        "${pkgs.xorg.xrandr}/bin/xrandr --output eDP --mode 1920x1080 --rate 60.00";
    })
  ];
}
