# NixOS X11 settings

{ config, pkgs, ... }:

{
  # create feh and dunst systemd service.
  systemd.user.services = {
    feh = {
      Unit = {
        Description = "Set window manager background with feh";
        PartOf = [ "qtile-session.target" ];
        Requires = [ "xrandr.service" ];
        After = [ "xrandr.service" ];
      };

      Install = { WantedBy = [ "qtile-session.target" ]; };
      Service = {
        ExecStart = "${config.home.homeDirectory}/.fehbg"; 
        Restart = "on-failure";
      };
    };

    dunst = {
      Unit = {
        Description = "Start Dunst notification daemon";
        PartOf = [ "qtile-session.target" ];
      };

      Install = { WantedBy = [ "qtile-session.target" ]; };
      Service = {
        ExecStart = "${pkgs.dunst}/bin/dunst -conf ${config.home.homeDirectory}/.config/dunst/dunstrc-tokyonight";
        Restart = "on-failure";
      };
    };
  };

  # Install xinitrc files in home directory.
  home.file = {
    ".xinitrc-i3" = {
      enable = true;
      source = ./../../../common/home/.xinitrc-i3;
    };

    ".xinitrc-qtile" = {
      enable = true;
      source = ./../../../common/home/.xinitrc-qtile;
    };
  };
}                   
      
