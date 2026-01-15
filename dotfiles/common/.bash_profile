# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# Source .profile
[ -f $HOME/.profile ] && . $HOME/.profile

# Source .nix_profile for nix-specific variables.
[ -f $HOME/.nix_profile ] && . $HOME/.nix_profile

# set qt platformtheme
#QT_QPA_PLATFORMTHEME=gtk3

# add paths for themes and desktop shortcuts installed through nix and flatpak.
export XDG_DATA_DIRS=/usr/local/share/:/usr/share/:$HOME/.local/share/:$HOME/.nix-profile/share/:/var/lib/flatpak/exports/share/:$HOME/.local/share/flatpak/exports/share

# set locale archive for programs installed through guix.
export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale

# set locale archive variable for nix programs
#export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# Set variable for guix package manager and source guix user profile.
GUIX_PROFILE="/home/joppe/.config/guix/current"
. "$GUIX_PROFILE/etc/profile"

# autologin on tty1
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
  ELECTRON_OZONE_PLATFORM_HINT=wayland exec dbus-run-session river
fi
