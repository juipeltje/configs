# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# set qt platformtheme
#QT_QPA_PLATFORMTHEME=gtk3

# add desktop shortcuts for nix programs to xdg-data-dirs
#export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS

# set locale archive variable for nix programs
#export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# sets firefox to run under wayland or xorg, depending on if the started session is a wayland session, or an xorg session
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  export MOZ_ENABLE_WAYLAND=1
fi

# autologin on tty1
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
  exec sway
fi
