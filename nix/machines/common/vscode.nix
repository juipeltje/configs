# Home Manager vscode configuration

{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        catppuccin.catppuccin-vsc
        dracula-theme.theme-dracula
        jdinhlife.gruvbox
        arcticicestudio.nord-visual-studio-code
        brandonkirbyson.solarized-palenight
        enkia.tokyo-night
        ms-python.python
        ms-python.black-formatter
      ];
    };
  };
}
      
