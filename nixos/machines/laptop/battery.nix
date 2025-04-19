# NixOS laptop battery life configuration

{ config, pkgs, ... }:

{
  # Enable tlp and settings, and logind settings.
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

    logind = {
      lidSwitch = "suspend-then-hibernate";
    };
  };

  # systemd timer and service to notify users when battery is low/critical.
  systemd = {
    user = {
      services = { 
        battery-low = {
          enable = true;
          description = "Script to notify users when battery is low/critical";
          partOf = [ "graphical-session.target" ];
          wantedBy = [ "graphical-session.target" ];
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

        # Service to notify when battery is charging/discharging.
        charger = {
          enable = true;
          description = "Script to notify users when battery is charging/discharging.";
          partOf = [ "graphical-session.target" ];
          wantedBy = [ "graphical-session.target" ];
          path = with pkgs; [ libnotify dbus ];
          script = ''
            BATTERY="/sys/class/power_supply/BAT0"
            STATUS=$(cat $BATTERY/status)

            while true; do
            	REAL_STATUS=$(cat $BATTERY/status)

            	if [ "$REAL_STATUS" != "$STATUS" ]; then
                  STATUS=$REAL_STATUS
                  notify-send "󰚥 Battery $(cat /sys/class/power_supply/BAT0/status)..."
            	fi
            done
          '';  
        };

        # Service to notify when battery is fully charged.
        battery-full = {
          enable = true;
          description = "Script to notify users when battery is fully charged.";
          partOf = [ "graphical-session.target" ];
          wantedBy = [ "graphical-session.target" ];
          path = with pkgs; [ libnotify dbus ];
          script = ''
            BATTERY="/sys/class/power_supply/BAT0"
            STATUS=NotFull

            while true; do
                REAL_STATUS=$(cat $BATTERY/status)

            	if [ "$REAL_STATUS" = "Full" -a "$REAL_STATUS" != "$STATUS" ]; then
                  STATUS=$REAL_STATUS
                  notify-send "󰂅 Battery fully charged!"
            	  sleep 120
            	elif [ "$REAL_STATUS" != "$STATUS" ]; then
            	  STATUS=NotFull
            	  sleep 120
            	fi
            done
          '';  
        };
      };

      timers = {
        battery-low = {
          enable = true;
          description = "Periodical checking of battery status every 2 minutes";
          requires = [ "battery-low.service" ];
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnBootSec = "2min";
            OnUnitActiveSec = "2min";
          };
        };
      };
    };

    # systemd service and timer that hibernates laptop when battery is critical.
    services = {
      battery-critical = {
        enable = true;
        description = "Script that hibernates laptop when battery is critical";
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
      battery-critical = {
        enable = true;
        description = "Periodical checking of battery status every 2 minutes";
        requires = [ "battery.service" ];
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "2min";
          OnUnitActiveSec = "2min";
        };
      };
    };
  };
}
