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

      # x
      dunst
      flameshot
      i3lock-color
      libnotify
      picom
      rofi
      xclip
      xss-lock

      #
      clang-tools
      cmake
      llvmPackages.clang
      llvmPackages.lldb

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

      # cmdline-stuff
      bat
      btop
      dex
      dust
      fdupes
      kitty
      ouch
      yazi

      # media
      feh
      ffmpeg_7-full
      libjxl
      mpd
      mpv
      nomacs
      pavucontrol
      rmpc

      # editor
      # kdePackages.kdenlive
      losslesscut-bin
      pixieditor

      # documents
      evince
      foliate
      mupdf

      # download
      aria2
      deno # for yt-dlp
      gallery-dl
      yt-dlp

      # theming
      fontpreview
      libsForQt5.qt5ct
      lxappearance
      qt6Packages.qt6ct
    ];
  };
}
