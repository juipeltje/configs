#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
# Void aliases
alias xl="xbps-query -l | awk '{ print \$2 }' | xargs -n1 xbps-uhelper getpkgname"
alias xu='sudo /home/joppe/repos/configs/scripts/installers/void-updater.sh'
alias xs='xbps-query -Rs'
#alias xi='sudo xbps-install -S'
alias xr='sudo xbps-remove -R'
alias xc='sudo xbps-remove -Oo'
alias xd='~/repos/configs/scripts/installers/dotfiles.sh'
#
# Nix aliases
alias ni="dbus-run-session sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon"
alias hi="dbus-run-session nix run --extra-experimental-features 'nix-command flakes' home-manager/release-25.11 -- switch --extra-experimental-features 'nix-command flakes'"
alias nu='nix flake update --flake ~/repos/configs/nix; home-manager switch --flake ~/repos/configs/nix'
alias hs='home-manager switch --flake ~/repos/configs/nix'
#
# NixOS aliases
#alias rb='sudo nixos-rebuild boot --flake ~/repos/configs/nixos'
#alias rs='sudo nixos-rebuild switch --flake ~/repos/configs/nixos'
#alias ru='sudo nix flake update --flake ~/repos/configs/nixos; sudo nixos-rebuild switch --flake ~/repos/configs/nixos'
#alias gc='sudo nix-collect-garbage; sudo nix-store --optimise'
alias ugc='nix-collect-garbage; nix-store --optimise'
#alias fgc='sudo nix-collect-garbage; sudo nix-collect-garbage -d; sudo nix-store --optimise'
alias fugc='nix-collect-garbage; nix-collect-garbage -d; nix-store --optimise'
#alias hs='home-manager switch --flake ~/repos/configs/nixos'
#
#alias alsa-store='alsactl --file ~/.config/asound.state store'
alias vpn-up='wg-quick up /etc/wireguard/be-bru-wg-102.conf'
alias vpn-down='wg-quick down /etc/wireguard/be-bru-wg-102.conf'
alias do-script='~/repos/configs/scripts/darkorbit-afk-script.sh'
alias rip-cd='cyanrip -s 6 -C ~/Downloads/album-art/Front.jpg -Q'
alias ytdl='yt-dlp -t mkv --embed-thumbnail --cookies-from-browser firefox:${HOME}/.librewolf/'
#alias A3='eval "$(/home/joppe/anaconda3/bin/conda shell.bash hook)"'
#alias gpu-split-size='export PYTORCH_HIP_ALLOC_CONF=garbage_collection_threshold:0.6,max_split_size_mb:128'
#alias launch-a1111='./webui.sh --upcast-sampling --medvram-sdxl'
# PS1="\[\e[0;36m\][\u@\h \W]\$ \[\e[m\]"
# PS1="\[\e[0;34m\][\u@\h \W]\$ \[\e[m\]"
PS1="\[\e[0;32m\] \u@\h  \W  \[\e[m\]"
# neofetch
# echo -e "\033[96;1;3mHi Joppe! Glad to see you're still using Arch btw ;)\033[0m"
# echo -e "\033[34;1;3mHi Joppe! Glad to see you're still using Arch btw ;)\033[0m"
