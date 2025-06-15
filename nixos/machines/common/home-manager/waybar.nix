# Home Manager Waybar configuration

{ config, pkgs, ... }:

# wrapping sed commands inside of bash scripts for systemd services.
let
  waybar_modules_dwl = pkgs.writers.writeBash "waybar-modules-dwl" ''
    ${pkgs.gnused}/bin/sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/modules-dwl\",|' ${config.home.homeDirectory}/.config/waybar/config
  '';

  waybar_modules_hyprland = pkgs.writers.writeBash "waybar-modules-hyprland" ''
    ${pkgs.gnused}/bin/sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/modules-hyprland\",|' ${config.home.homeDirectory}/.config/waybar/config
  '';

  waybar_modules_niri = pkgs.writers.writeBash "waybar-modules-niri" ''
    ${pkgs.gnused}/bin/sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/modules-niri\",|' ${config.home.homeDirectory}/.config/waybar/config
  '';

  waybar_modules_river = pkgs.writers.writeBash "waybar-modules-river" ''
    ${pkgs.gnused}/bin/sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/modules-river\",|' ${config.home.homeDirectory}/.config/waybar/config
  '';

  waybar_modules_sway = pkgs.writers.writeBash "waybar-modules-sway" ''
    ${pkgs.gnused}/bin/sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/modules-sway\",|' ${config.home.homeDirectory}/.config/waybar/config
  '';
in

{
  xdg.configFile = {
    "waybar/catppuccin-mocha.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/catppuccin-mocha.css;
    };

    "waybar/dracula.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/dracula.css;
    };

    "waybar/gruvbox-dark.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/gruvbox-dark.css;
    };

    "waybar/modules-dwl" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/modules-dwl;
    };

    "waybar/modules-hyprland" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/modules-hyprland;
    };

    "waybar/modules-niri" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/modules-niri;
    };

    "waybar/modules-river" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/modules-river;
    };

    "waybar/modules-sway" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/modules-sway;
    };

    "waybar/nord.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/nord.css;
    };

    "waybar/solarized-dark.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/solarized-dark.css;
    };

    "waybar/style.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/style.css;
    };

    "waybar/tokyonight.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/tokyonight.css;
    };
  };

  # create Systemd services for loading waybar modules depending on which compositor is started.
  systemd.user.services = {
    waybar-dwl = {
      Unit = {
        Description = "Waybar DWL modules";
        PartOf = [ "dwl-session.target" ];
        Before = [ "waybar.service" ];
      };

      Install = { WantedBy = [ "dwl-session.target" ]; };
      Service = {
        Type = "oneshot";
        ExecStart = "${waybar_modules_dwl}";
        Restart = "on-failure";
      };
    };

    waybar-hyprland = {
      Unit = {
        Description = "Waybar Hyprland modules";
        PartOf = [ "hyprland-session.target" ];
        Before = [ "waybar.service" ];
      };

      Install = { WantedBy = [ "hyprland-session.target" ]; };
      Service = {
        Type = "oneshot";
        ExecStart = "${waybar_modules_hyprland}";
        Restart = "on-failure";
      };
    };

    waybar-niri = {
      Unit = {
        Description = "Waybar Niri modules";
        PartOf = [ "niri-session.target" ];
        Before = [ "waybar.service" ];
      };

      Install = { WantedBy = [ "niri-session.target" ]; };
      Service = {
        Type = "oneshot";
        ExecStart = "${waybar_modules_niri}";
        Restart = "on-failure";
      };
    };

    waybar-river = {
      Unit = {
        Description = "Waybar River modules";
        PartOf = [ "river-session.target" ];
        Before = [ "waybar.service" ];
      };

      Install = { WantedBy = [ "river-session.target" ]; };
      Service = {
        Type = "oneshot";
        ExecStart = "${waybar_modules_river}";
        Restart = "on-failure";
      };
    };

    waybar-sway = {
      Unit = {
        Description = "Waybar Sway modules";
        PartOf = [ "sway-session.target" ];
        Before = [ "waybar.service" ];
      };

      Install = { WantedBy = [ "sway-session.target" ]; };
      Service = {
        Type = "oneshot";
        ExecStart = "${waybar_modules_sway}";
        Restart = "on-failure";
      };
    };
  };
}
