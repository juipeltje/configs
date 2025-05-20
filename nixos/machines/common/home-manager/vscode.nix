# Home Manager vscode configuration

{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs; [
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.catppuccin.catppuccin-vsc
      vscode-extensions.jdinhlife.gruvbox
      vscode-extensions.arcticicestudio.nord-visual-studio-code
      vscode-extensions.brandonkirbyson.solarized-palenight
      vscode-extensions.enkia.tokyo-night
    ];
  };
}
      
