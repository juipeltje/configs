# Home Manager vscode configuration

{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs; [
        vscode-extensions.jnoortheen.nix-ide
        vscode-extensions.catppuccin.catppuccin-vsc
        vscode-extensions.dracula-theme.theme-dracula
        vscode-extensions.jdinhlife.gruvbox
        vscode-extensions.arcticicestudio.nord-visual-studio-code
        vscode-extensions.brandonkirbyson.solarized-palenight
        vscode-extensions.enkia.tokyo-night
      ];

      userSettings = {
        "workbench.colorTheme" = "Gruvbox Dark Medium";
        "window.titleBarStyle" = "custom";
        "editor.fontFamily" = "Mononoki Nerd Font";
        "editor.fontSize" = 18;
      };
    };
  };
}
      
