{ pkgs, ... }:
{
  services.displayManager.sddm.wayland.enable = true;

  programs.sway.enable = true;
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    swappy
    swaybg
    swayidle
    swaylock-effects
    swaynotificationcenter

    fuzzel
    grim
    mako
    slurp
    waybar
    wl-clipboard
    xwayland
  ];
}
