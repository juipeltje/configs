# NixOS sound configuration

{ config, pkgs, ... }:

{
  # Enable sound with alsa and pipewire, set extra pipewire config options, and enable playerctld.
  security.rtkit.enable = true;
  services = {
    pipewire = {
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

    playerctld = {
      enable = true;
    };
  };

  # Enable alsa sound card state saving.
  hardware.alsa.enablePersistence = true;
}
