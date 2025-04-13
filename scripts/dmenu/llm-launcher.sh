#!/usr/bin/env bash

# LLM launcher script
if [ -n "$WAYLAND_DISPLAY" ]; then
	op=$( echo -e "󱚟  Deepseek-r1\n󱚟  Qwen2.5-coder" | fuzzel -d -w 10 --placeholder="Select LLM:" | awk '{print tolower($2)}' )
else
	op=$( echo -e "󱚟  Deepseek-r1\n󱚟  Qwen2.5-coder" | rofi -dmenu -p "Select LLM:" -theme-str 'window {width: 250px;}' | awk '{print tolower($2)}' )
fi

terminal=alacritty
hostname=$( cat /etc/hostname )

case $op in
        deepseek-r1)
                ;&
        qwen2.5-coder)
                if [ "$hostname" = NixOS-Rig ]; then
			$terminal -e ollama run $op:32b
		elif [ "$hostname" = NixOS-Lappie ]; then
			$terminal -e ollama run $op:7b
		fi
		;;
esac
