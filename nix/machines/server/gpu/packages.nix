# Home Manager packages configuration

{ config, pkgs, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Install packages for gpu-related services in home environment.
  home.packages = with pkgs; [
    # Jellyfin
    jellyfin
    # jellyfin-ffmpeg

    # Ollama
    ollama-rocm
 ];
}
