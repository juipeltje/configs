# NixOS SwayFX configs

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "sway/colors-catppuccin-mocha.conf" = {
          enable = true;
          source = ./../../../common/home/dotconfig/sway/colors-catppuccin-mocha.conf;
        };

        "sway/colors-gruvbox-dark.conf" = {
          enable = true;
          source = ./../../../common/home/dotconfig/sway/colors-gruvbox-dark.conf;
        };

        "sway/colors-nord.conf" = {
          enable = true;
          source = ./../../../common/home/dotconfig/sway/colors-nord.conf;
        };

        "sway/colors-solarized-dark.conf" = {
          enable = true;
          source = ./../../../common/home/dotconfig/sway/colors-solarized-dark.conf;
        };

        "sway/colors-tokyonight.conf" = {
          enable = true;
          source = ./../../../common/home/dotconfig/sway/colors-tokyonight.conf;
        };

        "sway/config" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."sway/config".source = ./../../../workstation/home/dotconfig/sway/config;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."sway/config".source = ./../../../laptop/home/dotconfig/sway/config;
    })
  ];
}
