{ pkgs, ... }:

let
  myFont = "JetBrainsMono Nerd Font";
in
{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      fira-code
      font-awesome
      nerd-fonts.jetbrains-mono

      # Reading
      inter
      open-sans
      roboto
      emacs-all-the-icons-fonts
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      includeUserConf = true;
      hinting.enable = true;
      hinting.style = "slight";
      subpixel.rgba = "rgb";
      subpixel.lcdfilter = "default";

      localConf = ''
        <match target="pattern">
          <test name="family" qual="any">
            <string>${myFont}</string>
          </test>
          <edit name="weight" mode="assign">
            <const>medium</const>
          </edit>
        </match>
      '';

      defaultFonts = {
        monospace = [ "${myFont}" ];
        sansSerif = [ "${myFont}" ];
        serif = [ "${myFont}" ];

      };
    };
  };
}
