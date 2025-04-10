# NixOS Hyprland configs

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "hypr/colors-catppuccin-mocha.conf" = {
          enable = true;
          source = ./../../../common/home/dotconfig/hypr/colors-catppuccin-mocha.conf;
        };

        "hypr/colors-gruvbox-dark.conf" = {
          enable = true;
          source = ./../../../common/home/dotconfig/hypr/colors-gruvbox-dark.conf;
        };

        "hypr/colors-nord.conf" = {
          enable = true;
          source = ./../../../common/home/dotconfig/hypr/colors-nord.conf;
        };

        "hypr/colors-solarized-dark.conf" = {
          enable = true;
          source = ./../../../common/home/dotconfig/hypr/colors-solarized-dark.conf;
        };

        "hypr/colors-tokyonight.conf" = {
          enable = true;
          source = ./../../../common/home/dotconfig/hypr/colors-tokyonight.conf;
        };

        "hypr/hyprland.conf" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."hypr/hyprland.conf".source = ./../../../workstation/home/dotconfig/hypr/hyprland.conf;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."hypr/hyprland.conf".source = ./../../../laptop/home/dotconfig/hypr/hyprland.conf;
    })
  ];
}
