{ ... }:
{
  boot = {
    # Fixes a common HP bug where 'intel_vbtn' sends ghost "tablet-mode" events
    # which can disable the touchpad or keyboard in i3.
    blacklistedKernelModules = [ "intel_vbtn" ];

    # Fix shutdown on my laptop
    kernelParams = [
      "acpi=force"
      "reboot=pci"
    ];
  };

  # no
  services.speechd.enable = false;

  # Laptop: Closing the lid
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
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
