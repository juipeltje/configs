#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias list-packages="xbps-query -l | awk '{ print \$2 }' | xargs -n1 xbps-uhelper getpkgname"
alias update='sudo xbps-install -u xbps && sudo xbps-install -Su'
alias full-update='sudo xbps-install -u xbps && sudo xbps-install -Su && flatpak update'
alias xq='xbps-query -Rs'
alias xi='sudo xbps-install -S'
alias xr='sudo xbps-remove -R'
alias xc='sudo xbps-remove -Oo'
alias vpn-up='wg-quick up /etc/wireguard/be-bru-wg-102.conf'
alias vpn-down='wg-quick down /etc/wireguard/be-bru-wg-102.conf'
alias autotiling-master='~/test-autotiling/bin/python ~/test-autotiling/test-autotiling.py --splitratio 1.61 --limit 2'
alias autotiling-dwindle='~/test-autotiling/bin/python ~/test-autotiling/test-autotiling.py --splitratio 1.61' 
alias do-script='~/repos/configs/Scripts/darkorbit-afk-script.sh'
alias A3='eval "$(/home/joppe/anaconda3/bin/conda shell.bash hook)"'
alias gpu-split-size='export PYTORCH_HIP_ALLOC_CONF=garbage_collection_threshold:0.6,max_split_size_mb:128'
alias launch-a1111='./webui.sh --upcast-sampling --medvram-sdxl'
# PS1="\[\e[0;36m\][\u@\h \W]\$ \[\e[m\]"
# PS1="\[\e[0;34m\][\u@\h \W]\$ \[\e[m\]"
PS1="\[\e[0;31m\] \u  \W  \[\e[m\]"
# neofetch
# echo -e "\033[96;1;3mHi Joppe! Glad to see you're still using Arch btw ;)\033[0m"
# echo -e "\033[34;1;3mHi Joppe! Glad to see you're still using Arch btw ;)\033[0m"


