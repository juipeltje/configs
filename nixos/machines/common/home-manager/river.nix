# Home Manager River configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "river/colors-catppuccin-mocha.sh" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/river/colors-catppuccin-mocha.sh;
        };

        "river/colors-dracula.sh" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/river/colors-dracula.sh;
        };

        "river/colors-gruvbox-dark.sh" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/river/colors-gruvbox-dark.sh;
        };

        "river/colors-nord.sh" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/river/colors-nord.sh;
        };

        "river/colors-solarized-dark.sh" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/river/colors-solarized-dark.sh;
        };

        "river/colors-tokyonight.sh" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/river/colors-tokyonight.sh;
        };

        "river/common.sh" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/river/common.sh;
        };

        "river/init" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."river/init".source = ./../../../../dotfiles/workstation/dotconfig/river/init;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."river/init".source = ./../../../../dotfiles/laptop/dotconfig/river/init;
    })
  ];
}
