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

  # It is necessary due to some intel drivers(see GPU) and Intel Microcode
  nixpkgs.config.allowUnfree = true;

  ################################
  #           IMPORTS            #
  ################################

  imports = [
    # The auto-generated hardware file (don't delete this!)
    ./hardware-configuration.nix

    ./machine/hp_laptop.nix
    ./modules/games.nix
    ./modules/chromium.nix

  ];

  ################################
  #          DISPLAY             #
  ################################

  # Auto-login without asking password prompt
  # programs.hyprland.enable = true;

  services = {
    #displayManager = {
    #  lightdm.enable = true;
    #  defaultSession = "none+i3";
    #  autoLogin = {
    #    enable = true;
    #    user = "kissu";
    #  };
    #};

    # Enable the X11 windowing system and i3
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "caps:ctrl_shifted_capslock";
        # options = "ctrl:swap_lalt_lctl,caps:ctrl_shifted_capslock";
      };
      windowManager.i3.enable = true;
      videoDrivers = [ "modesetting" ];
    };
  };

  # Wayland and niri
  programs.niri.enable = true;
  services.displayManager.sddm = {
    enable = true;
    # wayland.enable = true;
  };

  ################################
  #        USERS & GROUPS        #
  ################################

  # i3lock
  security.pam.services.i3lock = { };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kissu = {
    isNormalUser = true;
    home = "/home/kissu";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    packages = with pkgs; [
      bear
      emacs
      zed-editor

      # wayland
      # fuzzel
      # waybar
      # swaybg
      # mako
      # swaylock
      # xwayland

      # x
      rofi
      picom
      yazi

      #
      cmake
      clang-tools
      llvmPackages.lldb
      llvmPackages.clang

      # nix
      nil
      nixfmt-rfc-style

      # spell
      (aspellWithDicts (
        dicts: with dicts; [
          en
          en-computers
          en-science
        ]
      ))

      # desktop - interface
      kitty
      dunst
      libnotify
      flameshot
      i3lock-color
      xclip
      xss-lock

      # monitor/view
      btop
      activitywatch
      dex
      bat
      dust
      ouch

      # media
      mpv
      feh
      nomacs
      libjxl
      ffmpeg_7-full
      pavucontrol

      # documents
      evince
      mupdf

      # download
      aria2
      deno # for yt-dlp
      yt-dlp
      gallery-dl

      # theming
      fontpreview
      lxappearance
      libsForQt5.qt5ct
      qt6Packages.qt6ct
    ];
  };

  ################################
  #      SYSTEM_PACKAGES         #
  ################################

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lazygit
    git
    stow
    vim

    # disk
    smartmontools
    gsmartcontrol

    # Cli
    coreutils
    dos2unix
    fd
    fzf
    ripgrep
    trash-cli
    tldr
    tree
    xdg-utils

    # gpu stuff
    libva-utils
    mesa-demos
    acpi
    brightnessctl
    lm_sensors
  ];

  programs.firefox.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  ################################
  #    Networking & Firewall     #
  ################################

  networking.hostName = "nixos";
  networking.firewall.enable = true;

  # nmtui
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # Caps -> esc
  # services.xserver.xkb.options = "caps:escape";

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
