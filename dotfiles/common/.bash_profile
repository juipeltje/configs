# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# set qt platformtheme
#QT_QPA_PLATFORMTHEME=gtk3

# add paths for themes and desktop shortcuts installed through nix
#export XDG_DATA_DIRS=/usr/local/share/:/usr/share/:$HOME/.local/share/:$HOME/.nix-profile/share/

# set locale archive variable for nix programs
#export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# autologin on tty1
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
  ELECTRON_OZONE_PLATFORM_HINT=wayland exec sway
fi
