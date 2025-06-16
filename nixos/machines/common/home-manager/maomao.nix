# Home Manager maomao configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "maomao/colors-catppuccin-mocha.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/maomao/colors-catppuccin-mocha.conf;
        };

        "maomao/colors-dracula.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/maomao/colors-dracula.conf;
        };

        "maomao/colors-gruvbox-dark.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/maomao/colors-gruvbox-dark.conf;
        };

        "maomao/colors-nord.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/maomao/colors-nord.conf;
        };

        "maomao/colors-solarized-dark.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/maomao/colors-solarized-dark.conf;
        };

        "maomao/colors-tokyonight.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/maomao/colors-tokyonight.conf;
        };

        "maomao/common.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/maomao/common.conf;
        };

        "maomao/config.conf" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."maomao/config.conf".source = ./../../../../dotfiles/workstation/dotconfig/maomao/config.conf;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."maomao/config.conf".source = ./../../../../dotfiles/laptop/dotconfig/maomao/config.conf;
    })
  ];
}
