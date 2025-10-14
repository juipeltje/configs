# Home Manager container configuration

{ config, pkgs, ... }:

{
  # Enable Distrobox
  programs = {
    distrobox = {
      enable = true;
      enableSystemdUnit = false;
      containers = {
        ArchBox = {
          image = "docker.io/library/archlinux:latest";
          home = "${config.home.homeDirectory}/ArchBox/home";
          additional_packages = "displaycal fastfetch";
          additional_flags = "--env DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/host/var/run/dbus/system_bus_socket";
          hostname = "ArchBox";
          exported_apps = "DisplayCAL";
        };
      };
    };
  };

  # Enable Podman
  services.podman = {
    enable = true;
  };
}
