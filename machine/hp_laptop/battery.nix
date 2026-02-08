{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Power-management for laptop
  powerManagement.enable = true;
  services = {
    power-profiles-daemon.enable = false;
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        WOL_DISABLE = "Y";

        TLP_PERSISTENT_DEFAULT = 0;
        TLP_DEFAULT_MODE = "AC";

        INTEL_TURBO_BOOST_ON_AC = 0;
        INTEL_TURBO_BOOST_ON_BAT = 0;

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

        CPU_BOOST_ON_AC = 0;
        CPU_BOOST_ON_BAT = 0;

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;

        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 100;

        INTEL_GPU_MIN_FREQ_ON_AC = 300;
        INTEL_GPU_MAX_FREQ_ON_AC = 1000;
        INTEL_GPU_BOOST_FREQ_ON_AC = 1000;

        INTEL_GPU_MIN_FREQ_ON_BAT = 300;
        INTEL_GPU_MAX_FREQ_ON_BAT = 800; # Lower max GPU speed on battery
        INTEL_GPU_BOOST_FREQ_ON_BAT = 800;

        # Optional: helps save long term battery health; not supported on my Hp Laptop
        # START_CHARGE_THRESH_BAT0 = 30; # 30 and below it starts to charge
        # STOP_CHARGE_THRESH_BAT0 = 80;  # 80 and above it stops charging
      };
    };
  };
}
