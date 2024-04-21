# NixOS Rofi configs

{ config, pkgs, ... }:

{

  programs.rofi = {
    enable = true;
    font = "Ubuntu Nerd Font Medium 11";
    location = "center";
    terminal = "alacritty";
    theme = "tokyo-night";
    extraConfig = {
      modi = "drun";
      icon-theme = "Mint-Y-Aqua";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = " 󰀻  Apps ";
      sidebar-mode = true;
    };
  };

  xdg.configFile."rofi/tokyo-night.rasi" = {
    enable = true;
    text = ''
      * {
          bg-col:  #1a1b26;
          bg-col-light: #1a1b26;
          border-col: #a9b1d6;
          selected-col: #1a1b26;
          blue: #a9b1d6;
          fg-col: #565f89;
          fg-col2: #565f89;
          grey: #a9b1d6;

          width: 600;
          font: "Ubuntu Nerd Font Medium 14";
      }

      element-text, element-icon , mode-switcher {
          background-color: inherit;
          text-color:       inherit;
      }

      window {
          height: 360px;
          border: 4px;
          border-radius: 10px;
          border-color: @border-col;
          background-color: @bg-col;
      }

      mainbox {
          background-color: @bg-col;
      }

      inputbar {
          children: [prompt,entry];
          background-color: @bg-col;
          border-radius: 5px;
          padding: 2px;
      }

      prompt {
          background-color: @blue;
          padding: 6px;
          text-color: @bg-col;
          border-radius: 10px;
          margin: 20px 0px 0px 20px;
      }

      textbox-prompt-colon {
          expand: false;
          str: ":";
      }

      entry {
          padding: 6px;
          margin: 20px 0px 0px 10px;
          text-color: @fg-col;
          background-color: @bg-col;
      }

      listview {
          border: 0px 0px 0px;
          padding: 6px 0px 0px;
          margin: 10px 0px 0px 20px;
          columns: 2;
          lines: 5;
          background-color: @bg-col;
      }

      element {
          padding: 5px;
          background-color: @bg-col;
          text-color: @blue;
      }

      element-icon {
          size: 25px;
      }

      element selected {
          background-color:  @blue ;
          text-color: @bg-col  ;
          border-radius: 10px;
          border: 0px 5px 0px 0px;
      }

      mode-switcher {
          spacing: 0;
      }

      button {
          padding: 10px;
          background-color: @bg-col-light;
          text-color: @grey;
          vertical-align: 0.5;
          horizontal-align: 0.5;
      }

      button selected {
          background-color: @bg-col;
          text-color: @blue;
      }

      message {
          background-color: @bg-col-light;
          margin: 2px;
          padding: 2px;
          border-radius: 5px;
      }

      textbox {
          padding: 6px;
          margin: 20px 0px 0px 20px;
          text-color: @blue;
          background-color: @bg-col-light; 
      }
    '';
  };
}
