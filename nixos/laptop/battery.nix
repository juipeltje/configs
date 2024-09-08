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

  # systemd timer and service to notify users when battery is low/critical, and service to notify when battery is charging/discharging.
  systemd = {
    user = {
      services = { 
        battery = {
          unitConfig = { 
            Description = "Service to notify users when battery is low/critical";
          };

          serviceConfig = {
            Type = "oneshot";
          };

          path = with pkgs; [ libnotify dbus ];
          script = ''
            BATTERY="/sys/class/power_supply/BAT0"
            CAPACITY=$(cat $BATTERY/capacity)
            STATUS=$(cat $BATTERY/status)

            if [ "$STATUS" = Discharging -a "$CAPACITY" -lt 5 ]; then
            	notify-send -u critical "󱃍 Battery critical: $(cat /sys/class/power_supply/BAT0/capacity)%" "Now hibernating..."
            elif [ "$STATUS" = Discharging -a "$CAPACITY" -lt 16 ]; then
            	notify-send -u critical "󱃍 Battery low: $(cat /sys/class/power_supply/BAT0/capacity)%" "please connect a charger"
            fi
          '';  
        };

        charger = {
          unitConfig = { 
            Description = "Service to notify users when battery is charging/discharging.";
          };

          serviceConfig = {
            Type = "simple";
          };

          wantedBy = [ "default.target" ];

          path = with pkgs; [ libnotify dbus ];
          script = ''
            BATTERY="/sys/class/power_supply/BAT0"
            STATUS=$(cat $BATTERY/status)

            while true; do
            	REAL_STATUS=$(cat $BATTERY/status)

            if [ $REAL_STATUS != $STATUS ]; then
                STATUS=$REAL_STATUS
                notify-send "󰚥 Battery $(cat /sys/class/power_supply/BAT0/status)..."
            fi
            done
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

    # systemd service and timer that hibernates laptop when battery is critical.
    services = {
      battery = {
        unitConfig = {
          Description = "Service that hibernates laptop when battery is critical";
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
