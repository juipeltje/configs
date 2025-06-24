# Home Manager Wayland configuration

{ config, pkgs, ... }:

{
  # create swaybg and Mako Systemd services.
  systemd.user.services = {
    swaybg = {
      Unit = {
        Description = "Swaybg wallpaper tool for wayland compositors";
        ConditionEnvironment = "WAYLAND_DISPLAY";
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
      Service = { 
        ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${config.home.homeDirectory}/Pictures/background/background.jpg -m fill"; 
        Restart = "on-failure";
      };
    };

    mako = {
      Unit = {
        Description = "Mako notification daemon";
        ConditionEnvironment = "WAYLAND_DISPLAY";
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
      Service = {
        ExecStart = "${pkgs.mako}/bin/mako -c ${config.home.homeDirectory}/.config/mako/gruvbox-dark-config";
        Restart = "on-failure";
      };
    };
  };
}                   
      
