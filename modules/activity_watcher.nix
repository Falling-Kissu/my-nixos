{ pkgs, ... }:

let
  sameTargets = [
    "graphical-session.target"
    "wayland-session.target"
    "default.target"
  ];
  commonConfig = {
    after = sameTargets;
    wantedBy = sameTargets;
  };
  delay_start = "${pkgs.coreutils}/bin/sleep 16";
in
{
  environment.systemPackages = with pkgs; [
    activitywatch
    awatcher
  ];

  # background service for activity watch server
  systemd.user.services.activitywatch = {
    description = "ActivityWatch Server";
    inherit (commonConfig) after wantedBy;
    serviceConfig = {
      ExecStartPre = delay_start;
      ExecStart = "${pkgs.activitywatch}/bin/aw-server";
      Restart = "on-failure";
    };
  };

  # running awatcher as a service too
  systemd.user.services.awatcher = {
    description = "ActivityWatch Wayland Watcher";
    inherit (commonConfig) wantedBy;
    serviceConfig = {
      ExecStartPre = delay_start;
      ExecStart = "${pkgs.awatcher}/bin/awatcher";
      Restart = "always";
      RestartSec = 5;
    };
  };
}
