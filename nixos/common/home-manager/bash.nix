# NixOS Bash configs

{ config, pkgs, ... }:

{
  home.file = {
    ".bashrc" = {
      enable = true;
      source = ./../../../common/home/.bashrc;
    };

    ".bash_profile" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/configs/common/home/.bash_profile";
    };
  };
}
