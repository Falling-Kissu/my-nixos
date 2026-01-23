{ pkgs, ... }:
{
  ################################
  #        USERS & GROUPS        #
  ################################

  # i3lock
  security.pam.services.i3lock = { };

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
      kdePackages.kate

      # wayland
<<<<<<< HEAD
      fuzzel
      waybar
      swaybg
      mako
      swaylock
      xwayland
=======
      # fuzzel
      # waybar
      # swaybg
      # mako
      # swaylock
      # xwayland
>>>>>>> 0802d98 (refactoring:)

      # x
      rofi
      picom

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

      # gui related stuff
      dunst
      libnotify
      flameshot
      i3lock-color
      xclip
      xss-lock

      # cmdline-stuff
      kitty
      btop
      dex
      bat
      dust
      ouch
      yazi
      fdupes

      # media
      # kdePackages.kdenlive
      pixieditor
      losslesscut-bin
      mpv
      mpd
      rmpc
      feh
      nomacs
      libjxl
      ffmpeg_7-full
      pavucontrol

      # documents
      foliate
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
}
