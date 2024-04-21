# NixOS workstation polybar config

{ config, pkgs, ... }:

# polybar config.ini

  xdg.configFile = {
    "polybar/config.ini" = {
      enable = true;
      text = ''
        [colors]

        ## Nordic
        # background = #2e3440
        # background-alt = #4c566a
        # foreground = #d8dee9
        # primary = #8fbcbb
        # secondary = #81A1C1
        # alert = #bf616a
        # disabled = #707880

        ## Gruvbox-Material
        # background = #282828
        # background-alt = #282828
        # foreground = #dfbf8e
        # primary = #dfbf8e
        # secondary = #dfbf8e
        # alert = #ea6962
        # disabled = #707880

        ## Tokyo-Night
        background = #1a1b26
        background-alt = #1a1b26
        foreground = #a9b1d6
        primary = #a9b1d6
        secondary = #a9b1d6
        alert = #f7768e
        disabled = #707880

        [bar/bar1]
        width = 3420px
        height = 38px
        offset-x = 10px
        offset-y = 10px
        radius = 0
        background = ${colors.background}
        foreground = ${colors.foreground}
        line-size = 3pt
        border-size = 0px
        border-color = ${colors.primary}
        padding-left = 10px
        padding-right = 10px
        module-margin = 5px
        separator = " "
        separator-foreground = ${colors.disabled}
        font-0 = "Ubuntu Nerd Font:style=Medium:size=12;2"
        font-1 = "Mononoki Nerd Font:size=15;2"
        modules-left = time date i3 xwindow
        modules-center =
        modules-right = music kernel cpu gpu water pump fans memory controller
        cursor-click = pointer
        cursor-scroll = ns-resize
        enable-ipc = true
        tray-position = center
        tray-offset-x = -500
        wm-restack = i3
        override-redirect = true

        [module/i3]
        type = internal/i3
        enable-click = false
        enable-scroll = false
        ws-icon-0 = 1;%{T2} 1%{T-}
        ws-icon-1 = 2;%{T2} 2%{T-}
        ws-icon-2 = 3;%{T2} 3%{T-}
        ws-icon-3 = 4;%{T2} 4%{T-}
        ws-icon-4 = 5;%{T2} 5%{T-}
        ws-icon-5 = 6;%{T2} 6%{T-}
        ws-icon-6 = 7;%{T2} 7%{T-}
        ws-icon-7 = 8;%{T2} 8%{T-}
        label-focused-foreground = ${colors.primary}
        label-focused-padding = 2
        label-focused-underline = ${colors.primary}
        label-unfocused-foreground = ${colors.primary}
        label-unfocused-padding = 2
        label-visible-foreground = ${colors.primary}
        label-visible-padding = 2
        label-urgent-foreground = ${colors.alert}
        label-urgent-padding = 2

        [module/xwindow]
        type = internal/xwindow
        format-prefix = "%{T2}%{T-}    "
        format-prefix-foreground = ${colors.primary}
        label = %title%
        label-maxlen = 50

        [module/memory]
        type = custom/script
        label = %output%
        exec = free --mega | grep Mem | awk '{print$3" "$2}' | sed 's/ /\//' | sed 's/$/ MB/'
        interval = 5
        format-prefix = "%{T2}󰍛%{T-}  "
        format-prefix-foreground = ${colors.primary}

        [module/cpu]
        type = custom/script
        label = %output%
        exec = sensors k10temp-pci-00c3 | grep Tctl | awk '{print $2}' | sed 's/+/ /'
        interval = 5
        format-prefix = "%{T2}󰻠%{T-} "
        format-prefix-foreground = ${colors.primary}

        [module/gpu]
        type = custom/script
        label = %output%
        exec = sensors amdgpu-pci-0b00 | grep edge | awk '{print $2}' | sed 's/+/ /'
        interval = 5
        format-prefix = "%{T2}%{T-}  "
        format-prefix-foreground = ${colors.primary}

        [module/water]
        type = custom/script
        label = %output%
        exec = sensors | grep Coolant | awk '{print $2}' | sed 's/+/ /'
        interval = 5
        format-prefix = "%{T2}󰖌%{T-}"
        format-prefix-foreground = ${colors.primary}

        [module/pump]
        type = custom/script
        label = %output%
        exec = sensors | grep Pump | awk '{print $2" "$3}'
        interval = 5
        format-prefix = "%{T2}󱩃%{T-}  "
        format-prefix-foreground = ${colors.primary}

        [module/fans]
        type = custom/script
        label = %output%
        exec = sensors | grep fan2 | awk '{print $3" "$4}'
        interval = 5
        format-prefix = "%{T2}󰈐%{T-}   "
        format-prefix-foreground = ${colors.primary}

        [module/music]
        type = custom/script
        label = %output%
        label-maxlen = 50
        exec = playerctl metadata --format "{{ title }} - {{ artist }}"
        interval = 5
        tail = true
        format-prefix = "%{T2}󰝚%{T-}   "
        format-prefix-foreground = ${colors.primary}

        [module/controller]
        type = custom/script
        label = %output%
        exec = /home/joppe/repos/configs/Scripts/dualsense-bat.sh
        interval = 60
        format-prefix = "%{T2}󰖺%{T-}   "
        format-prefix-foreground = ${colors.primary}

        [module/power]
        type = custom/text
        content = %{T2}%{T-}
        content-foreground = ${colors.alert}
        click-left = exec rofi -theme-str 'window {width: 10%;}' -show power-menu -modi "power-menu:/home/joppe/Scripts/rofi-power-menu.sh --confirm=''"

        [module/kernel]
        type = custom/script
        label = %output%
        exec = uname -r
        interval = 120
        format-prefix = "%{T2}%{T-}    "
        format-prefix-foreground = ${colors.primary}

        [module/date]
        type = internal/date
        label = %date%
        interval = 60
        date = %d-%m-%Y
        format-prefix = "%{T2}%{T-}   "
        format-prefix-foreground = ${colors.primary}

        [module/time]
        type = internal/date
        label = %time%
        interval = 60
        time = %H:%M
        format-prefix = "%{T2}%{T-}   "
        format-prefix-foreground = ${colors.primary}

        [settings]
        screenchange-reload = true
        pseudo-transparency = true

        [bar/bar2]
        monitor = DisplayPort-1
        width = 2540px
        height = 38px
        offset-x = 10px
        offset-y = 10px
        radius = 0
        background = ${colors.background}
        foreground = ${colors.foreground}
        line-size = 3pt
        border-size = 0px
        border-color = ${colors.primary}
        padding-left = 10px
        padding-right = 10px
        module-margin = 5px
        separator = " "
        separator-foreground = ${colors.disabled}
        font-0 = "Ubuntu Nerd Font:style=Medium:size=12;2"
        font-1 = "Mononoki Nerd Font:size=15;2"
        modules-left = time date i3 xwindow
        modules-center =
        modules-right = music kernel cpu gpu water pump fans memory controller
        cursor-click = pointer
        cursor-scroll = ns-resize
        enable-ipc = true
        wm-restack = i3
        override-redirect = true
      '';
    };

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
