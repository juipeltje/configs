# NixOS Steam Deck Jovian configuration

{ config, pkgs, ... }:

{
  # Jovian-specific settings
  jovian = {
    devices.steamdeck.enable = false;
    steam = { 
      enable = true;
      autoStart = true;
      user = "joppe";
      desktopSession = "gnome";
    };
  };

  # Enable Gnome and Xwayland
  services.xserver.desktopManager.gnome.enable = true;
  programs.xwayland.enable = true;
  
  # Enable automatic login for the user.
  services.displayManager.autoLogin = { 
    enable = true;
    user = "joppe";
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services = { 
    "getty@tty1" = {
      enable = false;
    };

    "autovt@tty1" = {
      enable = false;
    };
  };
}
