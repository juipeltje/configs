# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# Source .profile
[ -f $HOME/.profile ] && . $HOME/.profile

# set qt platformtheme
#QT_QPA_PLATFORMTHEME=gtk3

# add paths for themes and desktop shortcuts installed through nix and flatpak.
export XDG_DATA_DIRS=/usr/local/share/:/usr/share/:$HOME/.local/share/:$HOME/.nix-profile/share/:/var/lib/flatpak/exports/share/:$HOME/.local/share/flatpak/exports/share

# set locale archive variable for nix programs
#export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# autologin on tty1
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
  ELECTRON_OZONE_PLATFORM_HINT=wayland exec dbus-run-session river
fi
