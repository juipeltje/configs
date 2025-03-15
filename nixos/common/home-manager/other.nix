# NixOS "other" configs

{ config, pkgs, ... }:

{
  home.file = {
    ".bash_profile" = {
      enable = true;
      source = ./../../../common/home/.bash_profile;
    };

    ".xinitrc-i3" = {
      enable = true;
      source = ./../../../common/home/.xinitrc-i3;
    };

    ".xinitrc-qtile" = {
      enable = true;
      source = ./../../../common/home/.xinitrc-qtile;
    };
  };
}
