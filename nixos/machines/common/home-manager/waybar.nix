# Home Manager Waybar configuration

{ config, hostName, lib, pkgs, ... }:

# wrapping sed commands inside of bash scripts for systemd services.
let
  waybar_dwl = pkgs.writers.writeBash "waybar-dwl" ''
    ${pkgs.gnused}/bin/sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/dwl-config\",|' ${config.home.homeDirectory}/.config/waybar/common
  '';

  waybar_hyprland = pkgs.writers.writeBash "waybar-hyprland" ''
    ${pkgs.gnused}/bin/sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/hyprland-config\",|' ${config.home.homeDirectory}/.config/waybar/common
  '';

  waybar_mwc = pkgs.writers.writeBash "waybar-mwc" ''
    ${pkgs.gnused}/bin/sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/mwc-config\",|' ${config.home.homeDirectory}/.config/waybar/common
  '';

  waybar_niri = pkgs.writers.writeBash "waybar-niri" ''
    ${pkgs.gnused}/bin/sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/niri-config\",|' ${config.home.homeDirectory}/.config/waybar/common
  '';

  waybar_river = pkgs.writers.writeBash "waybar-river" ''
    ${pkgs.gnused}/bin/sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/river-config\",|' ${config.home.homeDirectory}/.config/waybar/common
  '';

  waybar_sway = pkgs.writers.writeBash "waybar-sway" ''
    ${pkgs.gnused}/bin/sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/sway-config\",|' ${config.home.homeDirectory}/.config/waybar/common
  '';
in

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "waybar/catppuccin-mocha.css" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/waybar/catppuccin-mocha.css;
        };

        "waybar/config" = {
          enable = true;
        };

        "waybar/dracula.css" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/waybar/dracula.css;
        };

        "waybar/dwl-config" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/waybar/dwl-config;
        };

        "waybar/gruvbox-dark.css" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/waybar/gruvbox-dark.css;
        };

        "waybar/hyprland-config" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/waybar/hyprland-config;
        };

        "waybar/mwc-config" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/waybar/mwc-config;
        };

        "waybar/niri-config" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/waybar/niri-config;
        };

        "waybar/nord.css" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/waybar/nord.css;
        };

        "waybar/river-config" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/waybar/river-config;
        };

        "waybar/solarized-dark.css" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/waybar/solarized-dark.css;
        };

        "waybar/style.css" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/waybar/style.css;
        };

        "waybar/sway-config" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/waybar/sway-config;
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
            Description = "Waybar DWL config";
            PartOf = [ "dwl-session.target" "maomao-session.target" ];
            Before = [ "waybar.service" ];
          };

          Install = { WantedBy = [ "dwl-session.target" "maomao-session.target" ]; };
          Service = {
            Type = "oneshot";
            ExecStart = "${waybar_dwl}";
            Restart = "on-failure";
          };
        };

        waybar-hyprland = {
          Unit = {
            Description = "Waybar Hyprland config";
            PartOf = [ "hyprland-session.target" ];
            Before = [ "waybar.service" ];
          };

          Install = { WantedBy = [ "hyprland-session.target" ]; };
          Service = {
            Type = "oneshot";
            ExecStart = "${waybar_hyprland}";
            Restart = "on-failure";
          };
        };

        waybar-mwc = {
          Unit = {
            Description = "Waybar mwc config";
            PartOf = [ "mwc-session.target" ];
            Before = [ "waybar.service" ];
          };

          Install = { WantedBy = [ "mwc-session.target" ]; };
          Service = {
            Type = "oneshot";
            ExecStart = "${waybar_mwc}";
            Restart = "on-failure";
          };
        };

        waybar-niri = {
          Unit = {
            Description = "Waybar Niri config";
            PartOf = [ "niri-session.target" ];
            Before = [ "waybar.service" ];
          };

          Install = { WantedBy = [ "niri-session.target" ]; };
          Service = {
            Type = "oneshot";
            ExecStart = "${waybar_niri}";
            Restart = "on-failure";
          };
        };

        waybar-river = {
          Unit = {
            Description = "Waybar River config";
            PartOf = [ "river-session.target" ];
            Before = [ "waybar.service" ];
          };

          Install = { WantedBy = [ "river-session.target" ]; };
          Service = {
            Type = "oneshot";
            ExecStart = "${waybar_river}";
            Restart = "on-failure";
          };
        };

        waybar-sway = {
          Unit = {
            Description = "Waybar Sway config";
            PartOf = [ "sway-session.target" ];
            Before = [ "waybar.service" ];
          };

          Install = { WantedBy = [ "sway-session.target" ]; };
          Service = {
            Type = "oneshot";
            ExecStart = "${waybar_sway}";
            Restart = "on-failure";
          };
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."waybar/config".source = ./../../../../dotfiles/workstation/dotconfig/waybar/config;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."waybar/config".source = ./../../../../dotfiles/laptop/dotconfig/waybar/config;
    })
  ];
}
