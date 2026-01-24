{ ... }:
{
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
}
