{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    activitywatch
    awatcher
  ];

  # background service for activity watch server
  systemd.user.services.activitywatch = {
    description = "ActivityWatch Server";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.activitywatch}/bin/aw-server";
      Restart = "on-failure";
    };
  };

  # running awatcher as a service too
  systemd.user.services.awatcher = {
    description = "ActivityWatch Wayland Watcher";
    after = [
      "activitywatch.service"
      "wayland-session.target"
    ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.awatcher}/bin/awatcher";
      Restart = "on-failure";
    };
  };
}
