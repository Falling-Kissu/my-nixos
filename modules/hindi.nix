{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-m17n
      fcitx5-gtk
      libsForQt5.fcitx5-qt
    ];
  };

  environment.sessionVariables = {
    GLFW_IM_MODULE = "ibus";
    XMODIFIERS = "@im=fcitx";

    # Note: On modern Sway, native Wayland text-input protocols handle GTK/Qt.
    # Only uncomment these below if specific apps refuse to switch to Hindi:
    # GTK_IM_MODULE = "fcitx";
    # QT_IM_MODULE = "fcitx";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    lohit-fonts.devanagari
  ];

}
