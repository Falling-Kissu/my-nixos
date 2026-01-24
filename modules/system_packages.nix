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

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  environment.systemPackages = with pkgs; [
    git
    stow
    vim

    # disk
    gsmartcontrol
    smartmontools

    # Cli
    coreutils
    dos2unix
    fd
    fzf
    jq
    ripgrep
    tldr
    trash-cli
    tree
    xdg-utils

    # gpu stuff
    acpi
    brightnessctl
    libva-utils
    lm_sensors
    mesa-demos

    # networking
    wireguard-tools
  ];
}
