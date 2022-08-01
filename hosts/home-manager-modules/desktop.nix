{ config, lib, pkgs, user, ... }:

{
  home = {
    packages = with pkgs; [
      arandr
      libnotify
      scrot
      xclip
      xsel
      xss-lock
    ];
  };

  programs = {
    autorandr.enable = true;
  };

  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          monitor = 0;
          width = 300;
          # height = 5;
          # offset = "-30x30";
          separator_height = 2;
          padding = 8;
          frame_width = 1;
          frame_color = "#ebdbb2";
          ide_treshold = 120;
          font = "${font} 11";

          icon_position = "left";
          min_icon_size = 0;
          max_icon_size = 32;
        };
        urgency_low = {
          background = "#1d2021";
          foreground = "#ebdbb2";
          timeout = 10;
        };
        urgency_normal = {
          background = "#1d2021";
          foreground = "#ebdbb2";
          timeout = 10;
        };
        urgency_critical = {
          background = "#1d1f28";
          foreground = "#dcd7ba";
          frame_color = "#fb4934";
          timeout = 0;
        };
      };
    };

    gammastep = {
      enable = true;
      provider = "geoclue2";
      temperature = {
        day = 5700;
        night = 3500;
      };
    };

    picom.enable = true;
  };
}
