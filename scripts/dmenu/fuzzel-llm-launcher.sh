#!/usr/bin/env bash

op=$( echo -e "󱚟  Deepseek-r1\n󱚟  Qwen2.5-coder" | fuzzel -d -w 10 --placeholder="Select LLM:" | awk '{print tolower($2)}' )

terminal=alacritty
hostname=$( cat /etc/hostname )

case $op in
        deepseek)
                ;&
        qwen2.5-coder)
                if [ "$hostname" = NixOS-Rig ]; then
			$terminal -e ollama run $op:32b
		elif [ "$hostname" = NixOS-Lappie ]; then
			$terminal -e ollama run $op:7b
		fi
		;;
esac
