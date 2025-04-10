# NixOS River configs

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "river/colors-catppuccin-mocha.sh" = {
          enable = true;
          source = ./../../../common/home/dotconfig/river/colors-catppuccin-mocha.sh;
        };

        "river/colors-gruvbox-dark.sh" = {
          enable = true;
          source = ./../../../common/home/dotconfig/river/colors-gruvbox-dark.sh;
        };

        "river/colors-nord.sh" = {
          enable = true;
          source = ./../../../common/home/dotconfig/river/colors-nord.sh;
        };

        "river/colors-solarized-dark.sh" = {
          enable = true;
          source = ./../../../common/home/dotconfig/river/colors-solarized-dark.sh;
        };

        "river/colors-tokyonight.sh" = {
          enable = true;
          source = ./../../../common/home/dotconfig/river/colors-tokyonight.sh;
        };

        "river/init" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."river/init".source = ./../../../workstation/home/dotconfig/river/init;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."river/init".source = ./../../../laptop/home/dotconfig/river/init;
    })
  ];
}
