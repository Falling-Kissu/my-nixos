# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  ################################
  #            BOOT              #
  ################################

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };

    # I don't need latest kernel
    kernelPackages = pkgs.linuxPackages_6_12;

    # hides "Errors" and "Info" but keeps "Critical" and "Alerts"
    consoleLogLevel = 3;
  };

  ################################
  #            NIX               #
  ################################
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Have flakes
  nix.settings = {
    # keep-outputs = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # IMPORTANT: It is necessary due to some intel drivers(see GPU) and Intel Microcode
  nixpkgs.config.allowUnfree = true;

  ################################
  #           IMPORTS            #
  ################################

  imports = [
    # The auto-generated hardware file (don't delete this!)
    ./hardware-configuration.nix

    ./machine/hp_laptop.nix

    ./modules/system_packages.nix
    ./modules/user_packages.nix

    ./modules/games.nix
    ./modules/chromium.nix
  ];

  ################################
  #          DISPLAY             #
  ################################

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "caps:ctrl_shifted_capslock";
      };
      windowManager.i3.enable = true;
      videoDrivers = [ "modesetting" ];
    };
  };

  # Wayland and niri
  programs.sway.enable = true;
  programs.niri.enable = true;
  programs.hyprland.enable = true;

  # programs.niri.enable = true;
  # programs.hyprland.enable = true;
  services.displayManager.sddm = {
    enable = true;
    # wayland.enable = true;
  };

  ################################
  #    Networking & Firewall     #
  ################################

  networking.hostName = "nixos";
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;

  ################################
  #             Misc             #
  ################################

  # Making more documentation available
  documentation.man.enable = true;
  documentation.dev.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # qt
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };
  environment.sessionVariables = {
    QT_STYLE_OVERRIDE = pkgs.lib.mkForce "";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable Bluetooth hardware
  # hardware.bluetooth.enable = true;
  # hardware.bluetooth.powerOnBoot = true;
  # add a package: blueman

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  ################################
  ################################
  ################################

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
