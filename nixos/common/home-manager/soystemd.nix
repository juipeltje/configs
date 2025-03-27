# NixOS Systemd settings

{ config, pkgs, ... }:

{
  # create swaybg systemd service
  systemd.user.services = {
    swaybg = {
      Unit = {
        Description = "Set compositor background with swaybg";
        PartOf = [ "river-session.target" "hyprland-session.target" "qtile-wayland-session.target" "niri-session.target" ];
      };

      Install = { WantedBy = [ "river-session.target" "hyprland-session.target" "qtile-wayland-session.target" "niri-session.target" ]; };
      Service = { 
        ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${config.home.homeDirectory}/Pictures/sway/background.jpg -m fill"; 
        Restart = "on-failure";
      };
    };
  };
}                   
      
