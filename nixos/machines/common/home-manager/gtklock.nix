# Home Manager gtklock configuration

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "gtklock/config.ini" = {
      enable = true;
      text = ''
        [main]
        modules=${pkgs.gtklock-powerbar-module}/lib/gtklock/powerbar-module.so;${pkgs.gtklock-playerctl-module}/lib/gtklock/playerctl-module.so

        [playerctl]
        position=top-center
      '';
    };

    "gtklock/catppuccin-mocha.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/gtklock/catppuccin-mocha.css;
    };

    "gtklock/gruvbox-dark.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/gtklock/gruvbox-dark.css;
    };

    "gtklock/nord.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/gtklock/nord.css;
    };

    "gtklock/solarized-dark.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/gtklock/solarized-dark.css;
    };

    "gtklock/tokyonight.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/gtklock/tokyonight.css;
    };
  };
}
