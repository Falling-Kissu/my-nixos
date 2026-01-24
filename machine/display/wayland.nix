{ pkgs, ... }:
{
  services.displayManager.sddm.wayland.enable = true;

  programs.sway.enable = true;
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    fuzzel
    grim
    mako
    slurp
    swappy
    swaybg
    swayidle
    swaylock-effects
    waybar
    wl-clipboard
    xwayland
  ];
}
