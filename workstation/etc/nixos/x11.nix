# NixOS workstation X11 configuration

{ config, pkgs, ... }:

{

  # Enable the X11 windowing system, configure X11 keymap, X11 window managers, Kodi, and X11 config files.
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    excludePackages = [ pkgs.xterm ];
    windowManager = {
      i3.enable = true;
      i3.extraPackages = [ ];
      qtile.enable = true;
    };

    displayManager = {
      startx.enable = true;
      session = [
        { manage = "window";
          name = "i3-startx";
          start = ''
            ${pkgs.xorg.xinit}/bin/startx ~/.xinitrc-i3
          '';
        }

        { manage = "window";
          name = "qtile-startx";
          start = ''
            ${pkgs.xorg.xinit}/bin/startx ~/.xinitrc-qtile
          '';
        }
      ];
    };

    desktopManager = {
      kodi.package = pkgs.kodi;
      kodi.enable = true;
    };

    videoDrivers = [ "amdgpu" ];
    deviceSection = ''
      Option "TearFree" "true"
      Option "VariableRefresh" "true"
      Option "DRI" "3"
    '';
  };
}
