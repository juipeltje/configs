# Home Manager Hyprland configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "hypr/colors-catppuccin-mocha.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/hypr/colors-catppuccin-mocha.conf;
        };

        "hypr/colors-dracula.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/hypr/colors-dracula.conf;
        };

        "hypr/colors-gruvbox-dark.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/hypr/colors-gruvbox-dark.conf;
        };

        "hypr/colors-nord.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/hypr/colors-nord.conf;
        };

        "hypr/colors-solarized-dark.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/hypr/colors-solarized-dark.conf;
        };

        "hypr/colors-tokyonight.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/hypr/colors-tokyonight.conf;
        };

        "hypr/common.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/hypr/common.conf;
        };

        "hypr/hyprland.conf" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."hypr/hyprland.conf".source = ./../../../../dotfiles/workstation/dotconfig/hypr/hyprland.conf;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."hypr/hyprland.conf".source = ./../../../../dotfiles/laptop/dotconfig/hypr/hyprland.conf;
    })
  ];
}
