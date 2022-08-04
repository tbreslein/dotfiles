{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      thunderbird
      tdesktop
      libreoffice-fresh
      discord
      firefox
      brave
      thunderbird
      neomutt
      protonmail-bridge
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
      enable = true;
      settings.General.uiColor = "#fe8019";
    };
    network-manager-applet.enable = true;
    pasystray.enable = true;
  };
}
