#!/bin/sh

# River common config

# Variables
terminal="kitty"
file_manager="pcmanfm"
webbrowser="firefox"

# appearance

# cursor theme and size
riverctl xcursor-theme phinger-cursors-light 24

# Set border width
riverctl border-width 4

# import colors script
riverctl spawn ~/.config/river/colors-gruvbox-material-dark.sh

# layout settings
rivertile -view-padding 5 -outer-padding 5 -main-ratio 0.5 &
riverctl attach-mode bottom

# Keybindings

# open a terminal
riverctl map normal Super T spawn ${terminal}

# open freetube
riverctl map normal Super F spawn freetube

# open a terminal file manager
riverctl map normal Super Y spawn "${terminal} -e yazi"

# open a webbrowser
riverctl map normal Super W spawn ${webbrowser}

# open pavucontrol
riverctl map normal Super A spawn pavucontrol

# open deezer in a firefox window
riverctl map normal Super D spawn "${webbrowser} -new-window https://www.deezer.com/en/"

# open application launcher
riverctl map normal Super Space spawn ~/.config/river/tofi.sh

# open theme switcher
riverctl map normal Super+Shift T spawn ~/.config/river/tofi-theme-switcher.sh

# open powermenu
riverctl map normal Super Escape spawn ~/.config/river/tofi-powermenu.sh

# Mako notification history and close all notifications
riverctl map normal Super N spawn 'makoctl restore'
riverctl map normal Super C spawn 'makoctl dismiss --all'

# play/pause/previous/next keyboard controls
riverctl map normal None XF86AudioPlay spawn 'playerctl play-pause'
riverctl map normal None XF86AudioNext spawn 'playerctl next'
riverctl map normal None XF86AudioPrev spawn 'playerctl previous'

# exit river
riverctl map normal Super+Control Q exit

# close the focused view
riverctl map normal Super Q close

# focus the next/previous view in the layout stack
riverctl map normal Super Right focus-view next
riverctl map normal Super Left focus-view previous

# swap the focused view with the next/previous view in the layout stack
riverctl map normal Super+Shift Right swap next
riverctl map normal Super+Shift Left swap previous

# bump the focused view to the top of the layout stack
riverctl map normal Super Return zoom

# decrease/increase the main ratio of rivertile(1)
riverctl map normal Super KP_Subtract send-layout-cmd rivertile "main-ratio -0.05"
riverctl map normal Super KP_Add send-layout-cmd rivertile "main-ratio +0.05"

# toggle float
riverctl map normal Super+Shift Space toggle-float

# toggle fullscreen
riverctl map normal Super+Shift F toggle-fullscreen

# move and resize views, and toggle float with the mouse
riverctl map-pointer normal Super BTN_LEFT move-view
riverctl map-pointer normal Super BTN_RIGHT resize-view
riverctl map-pointer normal Super BTN_MIDDLE toggle-float

for i in $(seq 1 8)
do
    tags=$((1 << ($i - 1)))

    # focus tag [0-7]
    riverctl map normal Super $i set-focused-tags $tags

    # move focused view to tag [0-7]
    riverctl map normal Super+Shift $i set-view-tags $tags

done

# focus tag 0-7 with the numpad
riverctl map normal Super KP_End set-focused-tags $((1 << 0))
riverctl map normal Super KP_Down set-focused-tags $((1 << 1))
riverctl map normal Super KP_Next set-focused-tags $((1 << 2))
riverctl map normal Super KP_Left set-focused-tags $((1 << 3))
riverctl map normal Super KP_Begin set-focused-tags $((1 << 4))
riverctl map normal Super KP_Right set-focused-tags $((1 << 5))
riverctl map normal Super KP_Home set-focused-tags $((1 << 6))
riverctl map normal Super KP_Up set-focused-tags $((1 << 7))

# move focused view to tag 0-7 with the numpad
riverctl map normal Super+Shift KP_End set-view-tags $((1 << 0))
riverctl map normal Super+Shift KP_Down set-view-tags $((1 << 1))
riverctl map normal Super+Shift KP_Next set-view-tags $((1 << 2))
riverctl map normal Super+Shift KP_Left set-view-tags $((1 << 3))
riverctl map normal Super+Shift KP_Begin set-view-tags $((1 << 4))
riverctl map normal Super+Shift KP_Right set-view-tags $((1 << 5))
riverctl map normal Super+Shift KP_Home set-view-tags $((1 << 6))
riverctl map normal Super+Shift KP_Up set-view-tags $((1 << 7))

# scratchpad
# The scratchpad will live on an unused tag. Which tags are used depends on your
# config, but rivers default uses the first 9 tags.
scratch_tag=$((1 << 20 ))

# Toggle the scratchpad
riverctl map normal Super S toggle-focused-tags ${scratch_tag}

# Send windows to the scratchpad
riverctl map normal Super+Shift S set-view-tags ${scratch_tag}

# Set spawn tagmask to ensure new windows don't have the scratchpad tag unless explicitly set.
all_but_scratch_tag=$(( ((1 << 32) - 1) ^ ${scratch_tag} ))
riverctl spawn-tagmask ${all_but_scratch_tag}

# Set keyboard repeat rate
riverctl set-repeat 50 300

# Set the default layout generator to be rivertile and start it.
# River will send the process group of the init executable SIGTERM on exit.
riverctl default-layout rivertile

# cursor warp
riverctl set-cursor-warp on-focus-change

# cursor focus
riverctl focus-follows-cursor normal

# make all applications use server side decorations
riverctl rule-add ssd

# spawn a kitty terminal scratchpad at startup
riverctl rule-add -app-id scratchpad float
riverctl rule-add -app-id scratchpad tags ${scratch_tag}
riverctl spawn "kitty --class scratchpad"
