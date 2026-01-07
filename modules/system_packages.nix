{ pkgs, ... }:
{
  ################################
  #      SYSTEM_PACKAGES         #
  ################################

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

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

  environment.systemPackages = with pkgs; [
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

    # networking
    wireguard-tools
  ];
}
