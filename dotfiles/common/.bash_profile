# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# set qt platformtheme
#QT_QPA_PLATFORMTHEME=gtk3

# add desktop shortcuts for nix programs to xdg-data-dirs
#export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS

# set locale archive variable for nix programs
#export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# autologin on tty1
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
  ELECTRON_OZONE_PLATFORM_HINT=wayland exec maomao
fi
