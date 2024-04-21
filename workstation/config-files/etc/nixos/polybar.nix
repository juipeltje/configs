# NixOS workstation polybar config

{ config, pkgs, ... }:

# Polybar colors
# Tokyo-Night
let
  background = "#1a1b26";
  background-alt = "#1a1b26";
  foreground = "#a9b1d6";
  primary = "#a9b1d6";
  secondary = "#a9b1d6";
  alert = "#f7768e";
  disabled = "#707880";
in

# bar settings for both screens
let
  bar_settings = ''
    height = "38px";
    "offset-x" = "10px";
    offset-y = "10px";
    radius = 0;
    background = "${colors.background}";
    foreground = "${colors.foreground}";
    line-size = "3pt";
    bordersize = "0px";
    border-color = "${colors.primary}";
    padding-left = "10px";
    padding-right = "10px";
    module-margin = "5px";
    separator = " ";
    separator-foreground = "${colors.disabled}";
    font-0 = "Ubuntu Nerd Font:style=Medium:size=12;2";
    font-1 = "Mononoki Nerd Font:size=15;2";
    modules-left = "time date i3 xwindow";
    modules-right = "music kernel cpu gpu water pump fans memory controller";
    cursor-click = "pointer";
    cursor-scroll = "ns-resize";
    enable-ipc = true;
    wm-restack = "i3";
    override-redirect = true;
  '';
in

{

  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    config = {
      "settings" = {
        screenchange-reload = true;
        pseudo-transparency = true;
      };

      "bar/bar1" = {
        width = "3420px";
        tray-position = "center";
        "tray-offset-x" = "-500";
        ${bar_settings}
      };

      "bar/bar2" = {
        monitor = "DisplayPort-1";
        width = "2540px";
        ${bar_settings}
      };

      "module/i3" = {
        type = "internal/i3";
        enable-click = false;
        enable-scroll = false;
        ws-icon-0 = "1;%{T2} 1%{T-}";
        ws-icon-1 = "1;%{T2} 2%{T-}";
        ws-icon-2 = "1;%{T2} 3%{T-}";
        ws-icon-3 = "1;%{T2} 4%{T-}";
        ws-icon-4 = "1;%{T2} 5%{T-}";
        ws-icon-5 = "1;%{T2} 6%{T-}";
        ws-icon-6 = "1;%{T2} 7%{T-}";
        ws-icon-7 = "1;%{T2} 8%{T-}";
        label-focused-foreground = "${colors.primary}";
        label-focused-padding = 2;
        label-focused-underline = "${colors.primary}";
        label-unfocused-foreground = "${colors.primary}";
        label-unfocused-padding = 2;
        label-visible-foreground = "${colors.primary}";
        label-visible-padding = 2;
        label-urgent-foreground = "${colors.alert}";
        label-urgent-padding = 2;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        format-prefix = "%{T2}%{T-}    ";
        format-prefix-foreground = "${colors.primary}";
        label = "%title%";
        label-maxlen = 50;
      };

      "module/memory" = {
        type = "custom/script";
        label = "%output%";
        "exec" = "free --mega | grep Mem | awk '{print$3" "$2}' | sed 's/ /\//' | sed 's/$/ MB/'";
        interval = 5;
        format-prefix = "%{T2}󰍛%{T-}  ";
        format-prefix-foreground = "${colors.primary}";
      };

      "module/cpu" = {
        type = "custom/script";
        label = "%output%";
        "exec" = "sensors k10temp-pci-00c3 | grep Tctl | awk '{print $2}' | sed 's/+/ /'";
        interval = 5;
        format-prefix = "%{T2}󰻠%{T-} ";
        format-prefix-foreground = "${colors.primary}";
      };

      "module/gpu" = {
        type = "custom/script";
        label = "%output%";
        "exec" = "sensors amdgpu-pci-0b00 | grep edge | awk '{print $2}' | sed 's/+/ /'";
        interval = 5;
        format-prefix = "%{T2}%{T-}  ";
        format-prefix-foreground = "${colors.primary}";
      };

      "module/water" = {
        type = "custom/script";
        label = "%output%";
        "exec" = "sensors | grep Coolant | awk '{print $2}' | sed 's/+/ /'";
        interval = 5;
        format-prefix = "%{T2}󰖌%{T-}";
        format-prefix-foreground = "${colors.primary}";
      };

      "module/pump" = {
        type = "custom/script";
        label = "%output%";
        "exec" = "sensors | grep Pump | awk '{print $2" "$3}'";
        interval = 5;
        format-prefix = "%{T2}󱩃%{T-}  ";
        format-prefix-foreground = "${colors.primary}";
      };

      "module/fans" = {
        type = "custom/script";
        label = "%output%";
        "exec" = "sensors | grep fan2 | awk '{print $3" "$4}'";
        interval = 5;
        format-prefix = "%{T2}󰈐%{T-}   ";
        format-prefix-foreground = "${colors.primary}";
      };

      "module/music" = {
        type = "custom/script";
        label = "%output%";
        label-maxlen = 50;
        "exec" = "playerctl metadata --format '{{ title }} - {{ artist }}'";
        interval = 5;
        tail = true;
        format-prefix = "%{T2}󰝚%{T-}   ";
        format-prefix-foreground = "${colors.primary}";
      };

      "module/controller" = {
        type = "custom/script";
        label = "%output%";
        "exec" = "~/repos/configs/Scripts/dualsense-bat.sh";
        interval = 60;
        format-prefix = "%{T2}󰖺%{T-}   ";
        format-prefix-foreground = "${colors.primary}";
      };

      "module/kernel" = {
        type = "custom/script";
        label = "%output%";
        "exec" = "uname -r";
        interval = 120;
        format-prefix = "%{T2}%{T-}    ";
        format-prefix-foreground = "${colors.primary}";
      };

      "module/date" = {
        type = "internal/date";
        label = "%date%";
        interval = 60;
        date = "%d-%m-%Y";
        format-prefix = "%{T2}%{T-}   ";
        format-prefix-foreground = "${colors.primary}";
      };

      "module/time" = {
        type = "internal/date";
        label = "%time%";
        interval = 60;
        "time" = "%H:%M";
        format-prefix = "%{T2}%{T-}   ";
        format-prefix-foreground = "${colors.primary}";
      };
    };
  };

  # Polybar launch script
  xdg.configFile = {
    "polybar/launch.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env bash

        # Terminate already running bar instances
        killall -q polybar

        # Launch bars
        polybar bar1 &
        polybar bar2 &
      '';
    };
  };
}

      


