# NixOS Mako configs

{ config, pkgs, ... }:

{

  services.mako = {
    enable = true;
    font = "Ubuntu Nerd Font Medium 12";
    width = 300;
    height = 150;
    margin = "10";
    borderSize = 4;
    borderRadius = 10;
    icons = true;
    maxIconSize = 100;
    markup = true;
    actions = true;
    defaultTimeout = 5000;
    ignoreTimeout = true;
    maxVisible = 5;
    layer = "top";
    anchor = "top-right";
    sort = "-time";

    # Color themes
    # Tokyo-Night
    backgroundColor = "#1a1b26";
    textColor = "#a9b1d6";
    borderColor = "#a9b1d6";
  
    extraConfig = ''
      # bindings
      on-button-left=none
      on-button-middle=none
      on-button-right=none
      on-touch=none
      on-notify=none

      # config
      history=1
      max-history=10
      outer-margin=0,0,4,0
      icon-location=left
      text-alignment=left
    '';
  };
}
      
    

