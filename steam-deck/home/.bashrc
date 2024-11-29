#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
# Nix aliases
alias hs='TMPDIR=/home/deck/tmp home-manager switch --flake ~/configs/nixos#deck@Deckie'
alias cleanup='nix-collect-garbage && nix-store --optimise'
#
alias do-script='~/repos/configs/scripts/darkorbit-afk-script.sh'
# PS1="\[\e[0;36m\][\u@\h \W]\$ \[\e[m\]"
# PS1="\[\e[0;34m\][\u@\h \W]\$ \[\e[m\]"
PS1="\[\e[0;31m\] \u  \W  \[\e[m\]"
# neofetch
# echo -e "\033[96;1;3mHi Joppe! Glad to see you're still using Arch btw ;)\033[0m"
# echo -e "\033[34;1;3mHi Joppe! Glad to see you're still using Arch btw ;)\033[0m"

