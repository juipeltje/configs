# NixOS Steam Deck battery configuration

{ config, pkgs, ... }:

{
  # systemd service and timer that hibernates laptop when battery is critical.
  systemd = {
    services = {
      battery = {
        unitConfig = {
          Description = "Service that hibernates deck when battery is critical";
        };

        serviceConfig = {
          Type = "oneshot";
        };

        script = ''
          BATTERY="/sys/class/power_supply/BAT0"
          CAPACITY=$(cat $BATTERY/capacity)
          STATUS=$(cat $BATTERY/status)

          if [ "$STATUS" = Discharging -a "$CAPACITY" -lt 5 ]; then
          	sleep 5
                systemctl hibernate
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
