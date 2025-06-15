# Home Manager SwayFX configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "sway/colors-catppuccin-mocha.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/sway/colors-catppuccin-mocha.conf;
        };

        "sway/colors-dracula.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/sway/colors-dracula.conf;
        };

        "sway/colors-gruvbox-dark.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/sway/colors-gruvbox-dark.conf;
        };

        "sway/colors-nord.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/sway/colors-nord.conf;
        };

        "sway/colors-solarized-dark.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/sway/colors-solarized-dark.conf;
        };

        "sway/colors-tokyonight.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/sway/colors-tokyonight.conf;
        };

        "sway/common.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/sway/common.conf;
        };

        "sway/config" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."sway/config".source = ./../../../../dotfiles/workstation/dotconfig/sway/config;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."sway/config".source = ./../../../../dotfiles/laptop/dotconfig/sway/config;
    })
  ];
}
