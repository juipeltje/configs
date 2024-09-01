# NixOS laptop battery life configuration

{ config, pkgs, ... }:

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
  systemd.user = {
    services = { 
      battery = {
        unitConfig = { 
          Description = "Service to notify when battery is low and hibernate when critical";
        };

        serviceConfig = {
          Type = "oneshot";
        };

        path = with pkgs; [ libnotify dbus ];
        environment = { DISPLAY = ":0"; };
        script = ''
          BATTERY="/sys/class/power_supply/BAT0"
          CAPACITY=$(cat $BATTERY/capacity)
          STATUS=$(cat $BATTERY/status)

          if [ "$STATUS" = Discharging -a "$CAPACITY" -lt 5 ]; then
          	notify-send -u critical "󱃍 Battery critical: $(cat /sys/class/power_supply/BAT0/capacity)%" "Now hibernating..."
        	sleep 5
        	systemctl hibernate
          elif [ "$STATUS" = Discharging -a "$CAPACITY" -lt 16 ]; then
          	notify-send -u critical "󱃍 Battery low: $(cat /sys/class/power_supply/BAT0/capacity)%" "please connect a charger"
          fi
        '';  
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
