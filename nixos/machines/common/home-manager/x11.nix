# Home Manager X11 configuration

{ config, pkgs, ... }:

{
  # create feh and dunst systemd service.
  systemd.user.services = {
    feh = {
      Unit = {
        Description = "Feh wallpaper tool for X";
        PartOf = [ "qtile-session.target" "i3-session.target" ];
        Requires = [ "xrandr.service" ];
        After = [ "xrandr.service" ];
      };

      Install = { WantedBy = [ "qtile-session.target" "i3-session.target" ]; };
      Service = {
        ExecStart = "${config.home.homeDirectory}/.fehbg"; 
        Restart = "on-failure";
      };
    };

    dunst = {
      Unit = {
        Description = "Dunst notification daemon";
        PartOf = [ "qtile-session.target" "i3-session.target" ];
      };

      Install = { WantedBy = [ "qtile-session.target" "i3-session.target" ]; };
      Service = {
        ExecStart = "${pkgs.dunst}/bin/dunst -conf ${config.home.homeDirectory}/.config/dunst/dunstrc-gruvbox-dark";
        Restart = "on-failure";
      };
    };
  };

  # Install xinitrc files in home directory.
  home.file = {
    ".xinitrc-i3" = {
      enable = true;
      source = ./../../../../dotfiles/common/.xinitrc-i3;
    };

    ".xinitrc-qtile" = {
      enable = true;
      source = ./../../../../dotfiles/common/.xinitrc-qtile;
    };
  };
}                   
      
