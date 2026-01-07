{ ... }:
{
  boot = {
    # Fixes a common HP bug where 'intel_vbtn' sends ghost "tablet-mode" events
    # which can disable the touchpad or keyboard in i3.
    blacklistedKernelModules = [ "intel_vbtn" ];

    kernelParams = [
      # Force 'Deep Sleep' (S3) instead of 's2idle' to save batte  ry when lid is closed
      "mem_sleep_default=deep"

      "button.lid_init_state=open"
    ];
  };

  # no
  services.speechd.enable = false;

  # Laptop: Closing the lid
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
    CriticalPowerAction = "poweroff";
    IdleAction = "lock";
  };

  # Touchpad
  services.libinput.enable = true;

  # Time
  time.timeZone = "Asia/Kolkata";
  services.timesyncd.enable = true;
}
