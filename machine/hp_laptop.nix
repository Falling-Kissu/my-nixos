{ ... }:

let
  hp = f: ./. + "/hp_laptop/${f}.nix";
in
{
  imports = [
    (hp "laptop")
    (hp "fonts")
    (hp "disk")
    (hp "graphics")
    (hp "sound")
    (hp "battery")
    (hp "network")
  ];
}
