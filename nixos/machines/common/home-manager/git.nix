# Home Manager Git configuration

{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "juipeltje";
    userEmail = "joppe4444@outlook.com";
  };
}
