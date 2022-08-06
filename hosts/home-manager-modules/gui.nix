{ pkgs, colors, useWayland, ... }:

{
  home = {
    packages = with pkgs; [
      thunderbird
      tdesktop
      libreoffice-fresh
      discord
      firefox
      brave
      vivaldi
      thunderbird
      zoom-us
      birdtray
      megasync
      obs-studio
    ];
  };

  programs = {
    mpv.enable = true;
    zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
      };
    };
  };

  services = {
    flameshot = {
      enable = !useWayland;
      settings.General.uiColor = colors.primary.accent;
    };
    network-manager-applet.enable = true;
    pasystray.enable = true;
  };
}
