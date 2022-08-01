{ config, lib, pkgs, user, browser, mail, ... }:

{
  home = {
    packages = with pkgs; [
      thunderbird
      tdesktop
      libreoffice-fresh
      discord
      "${browser}"
      "${mail}"
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
    network-manager-applet.enable = true;
    pasystray.enable = true;
  };
}
