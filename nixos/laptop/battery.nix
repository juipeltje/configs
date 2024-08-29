# NixOS laptop battery life configuration

{ config, pkgs, ... }:

# script to notify when battery is low and hibernate when critical
let
  battery_script = pkgs.writers.writeBash "battery" ''
    BATTERY="/sys/class/power_supply/BAT0"
    CAPACITY=$(cat $BATTERY/capacity)
    STATUS=$(cat $BATTERY/status)

    if [ "$STATUS" = Discharging -a "$CAPACITY" -lt 5 ]; then
    	notify-send 'Now hibernating...' "Battery level critical"
        sleep 5
        systemctl hibernate
    elif [ "$STATUS" = Discharging -a "$CAPACITY" -lt 16 ]; then
    	notify-send 'Battery low ($CAPACITY%)' "please connect a charger"
    fi
  '';
in

{

  # Enable tlp and settings.
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
  };

  # systemd timer and service to run battery script every 2 minutes
  systemd = {
    services = { 
      battery = {
        unitConfig = { 
          Description = "Service to notify when battery is low and hibernate when critical";
        };

        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${battery_script}";
          User = "root";
          Group = "systemd-journal";
        };
      };
    };

    timers = {
      battery = {
        unitConfig = {
          Description = "Periodical checking of battery status every 2 minutes";
          Requires = "battery.service";
        };

        timerConfig = {
          OnBootSec = "2min";
          OnUnitActiveSec = "2min";
        };

        wantedBy = [ "timers.target" ];
      };
    };
  };
}
