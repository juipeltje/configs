# NixOS workstation X11 configuration

{ config, pkgs, ... }:

{
  # X11 videodriver config for workstation.
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    deviceSection = ''
      Option "TearFree" "true"
      Option "VariableRefresh" "true"
      Option "DRI" "3"
    '';
  };

  # Systemd service for xrandr
  systemd.user.services = {
    xrandr = {
      enable = true;
      unitConfig = {
        Description = "Set resolution and refreshrate with xrandr";
        Type = "oneshot";
        PartOf = [ "qtile-session.target" ];
      };

      serviceConfig = {
        ExecStart = "${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-0 --primary --mode 3440x1440 --rate 165.00 --output DisplayPort-1 --mode 2560x1080 --rate 74.99 --above DisplayPort-0";
        Restart = "on-failure";
      };

      wantedBy = [ "qtile-session.target" ];
    };
  };
}
