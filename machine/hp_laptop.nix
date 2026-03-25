{ pkgs, ... }:

let
  hp = f: ./. + "/hp_laptop/${f}.nix";
in
{
  imports = [
    (hp "laptop")
    (hp "disk")
    (hp "graphics")
    (hp "sound")
    (hp "battery")
    (hp "network")
  ];

  systemd.user.services.battery-monitor = {
    description = "Battery Monitor for BAT1 at 30%";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.writeShellScript "battery-check" ''
        BAT_PATH="/sys/class/power_supply/BAT1"
        while true; do
          # Use absolute paths for NixOS stability
          if [ -d "$BAT_PATH" ]; then
            LEVEL=$(${pkgs.coreutils}/bin/cat "$BAT_PATH/capacity")
            STATUS=$(${pkgs.coreutils}/bin/cat "$BAT_PATH/status")

            if [ "$LEVEL" -le 30 ] && [ "$STATUS" = "Discharging" ]; then
              ${pkgs.libnotify}/bin/notify-send -u critical "Battery Low: ''${LEVEL}%" "Plug in the charger.\nPLEASE!!! >.>"
              sleep 300
            fi
          fi
          sleep 60
        done
      ''}";
      Restart = "always";
      RestartSec = 5;
    };
  };
}
