{ ... }:

{
  # decreasing pain for my HDD (in 2025)
  boot = {
    kernelModules = [ "bfq" ];
    kernelParams = [ "elevator=bfq" ];
    kernel.sysctl = {
      "vm.swappiness" = 10;
    };
  };

  # Prevent HDD from writing access times to save disk wear
  fileSystems."/" = {
    options = [
      "noatime"
      "nodiratime"
    ];
  };
  # Encrypted partition: /dev/sda3: uuid-ee39a...
  systemd.tmpfiles.rules = [
    "d /home/vault 0700 kissu users -"
  ];
  boot.initrd.luks.devices."crypt-home" = {
    device = "/dev/disk/by-uuid/ee39a1c8-3f9e-496f-bf30-1e6890bb3906";
    preLVM = true;
  };
  fileSystems."/home/vault" = {
    device = "/dev/mapper/crypt-home";
    fsType = "ext4";
    options = [
      "noatime"
      "nodiratime"
      "nofail"
      "noauto"
      "x-systemd.automount"
    ];
  };
}
