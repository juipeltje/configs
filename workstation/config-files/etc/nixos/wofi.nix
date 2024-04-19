# NixOS Wofi configs

{ config, pkgs, ... }:

{

  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 400;
      height = 400;
      prompt = "";
      normal_window = true;
      allow_images = true;
      allow_markup = false;
      term = "alacritty";
      exec_search = false;
      hide_scroll = true;
      matching = "contains";
      insensitive = true;
      location = "center";
      columns = 1;
      sort_order = "default";
      gtk_dark = false;
      monitor = "DP-1";
      orientation = "vertical";
      image_size = 32;
    };

    style = ''
      * {
              font-family: Ubuntu Nerd Font;
              font-weight: 500;
              font-size: 16px;
      }

      window {
              margin: 5px;
              border: 4px #a9b1d6;
              background-color: #1a1b26;
      }

      #input {
              margin: 5px;
              border: 0px;
              background-color: #000000;
              border-radius: 20px;
      }

      #inner-box {
              margin: 5px;
              border: 0px;
              background-color: #1a1b26;
      }

      #outer-box {
              margin: 5px;
              border: 0px;
              background-color: #1a1b26;
      }

      #scroll {
              margin: 5px;
              border: 0px;
              background-color: #1a1b26;
      }

      #text {
              margin: 5px;
              border: 0px;
              background-color: #1a1b26;
      }

      #entry:selected {
              background-color: #a9b1d6;
              border-radius: 20px;
              outline: none;
      }

      #text:selected {
              background-color: #a9b1d6;
              color: #1a1b26;
      }
    '';
  };
}
       
