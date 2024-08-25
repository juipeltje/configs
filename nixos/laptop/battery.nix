# NixOS laptop battery life configuration

{ config, pkgs, ... }:

{

  # Enable tlp, upower, and their settings.
  services = {
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_MIN_FREQ_ON_AC = 2100000;
        CPU_SCALING_MAX_FREQ_ON_AC = 2100000;
        CPU_SCALING_MIN_FREQ_ON_BAT = 1400000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 2100000;
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
      };
    };

    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 4;
      criticalPowerAction = "Hibernate";
    };
  };
}
