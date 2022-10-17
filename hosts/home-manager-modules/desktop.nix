{ pkgs, lib, font, colors, homeDir, ... }:

let
  myColors = colors;
in
{
  home = {
    packages = with pkgs; [
      arandr
      dmenu
      libnotify
      pasystray
      pavucontrol
      scrot
      xclip
      xsel
      xss-lock
    ];
  };

  programs.autorandr.enable = true;

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
          frame_color = "#${colors.primary.foreground}";
          ide_treshold = 120;
          font = "${font} 11";

          icon_position = "left";
          min_icon_size = 0;
          max_icon_size = 32;
        };
        urgency_low = {
          background = "#${colors.primary.background}";
          foreground = "#${colors.primary.foreground}";
          timeout = 10;
        };
        urgency_normal = {
          background = "#${colors.primary.background}";
          foreground = "#${colors.primary.foreground}";
          timeout = 10;
        };
        urgency_critical = {
          background = "#${colors.primary.background}";
          foreground = "#${colors.primary.foreground}";
          frame_color = "#${colors.primary.alert}";
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
