#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias update='sudo xbps-install -u xbps && sudo xbps-install -Su'
alias full-update='sudo xbps-install -u xbps && sudo xbps-install -Su && flatpak update && pip freeze > requirements.txt && pip install -r requirements.txt --upgrade && rm requirements.txt' 
alias do-script='/usr/local/sbin/darkorbit-afk-script.sh'
alias set-msr='sudo /usr/local/sbin/msr.sh'
alias CPUWorker1='xmrig-mo --config /home/joppe/CPUWorker1/config.json'
alias GPUWorker1='miner --algo kawpow --server gulf.moneroocean.stream --port 10128 --user 44bnjvxBsBoQfkxzD9jeox4QP4dHPfzDC15ZHnHWajXeK23NW9wAzt4BAErqEMpSgjMAMJ1vg9pEr7boPSedZpsZCiVwZQ4.GPUWorker1 --opencl'
# PS1="\[\e[0;36m\][\u@\h \W]\$ \[\e[m\]"
# PS1="\[\e[0;34m\][\u@\h \W]\$ \[\e[m\]"
PS1="\[\e[0;31m\] \u  \W  \[\e[m\]"
# neofetch
# echo -e "\033[96;1;3mHi Joppe! Glad to see you're still using Arch btw ;)\033[0m"
# echo -e "\033[34;1;3mHi Joppe! Glad to see you're still using Arch btw ;)\033[0m"


