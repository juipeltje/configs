# NixOS sound configuration

{ config, pkgs, ... }:

{
  # Enable sound with alsa and pipewire and set extra pipewire config options.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.allowed-rates" = [ 44100 48000 96000 ];
        };
      };
    };
  };
}
