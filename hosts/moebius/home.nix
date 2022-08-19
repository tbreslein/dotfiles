{ config, pkgs, useWayland, ... }:

{
  programs = {
    alacritty.settings.font.size = 10;
    # autorandr.profiles = {
    #   "regular" = {
    #     fingerprint = {
    #       eDP1 = "<EDID>";
    #       DP1 = "<EDID>";
    #     };
    #     config = {
    #       eDP1.enable = false;
    #       DP1 = {
    #         enable = true;
    #         crtc = 0;
    #         primary = true;
    #         position = "0x0";
    #         mode = "3840x2160";
    #         gamma = "1.0:0.909:0.833";
    #         rate = "60.00";
    #         rotate = "left";
    #       };
    #     };
    #   };
    #   "tv" = {
    #     fingerprint = {
    #       eDP1 = "<EDID>";
    #       DP1 = "<EDID>";
    #     };
    #     config = {
    #       eDP1.enable = false;
    #       DP1 = {
    #         enable = true;
    #         crtc = 0;
    #         primary = true;
    #         position = "0x0";
    #         mode = "3840x2160";
    #         gamma = "1.0:0.909:0.833";
    #         rate = "60.00";
    #         rotate = "left";
    #       };
    #     };
    #   };
    # };
  };

  # services.kanshi = {
  #   enable = false;
  #   profiles = {
  #     standard = {
  #       # exec = [ "some command" ];
  #       outputs = [
  #         {
  #           criteria = "DP-1 Unknown Mi Monitor";
  #           mode = "3440x1440@144Hz";
  #           # position = "x,y";
  #         }
  #         {
  #           criteria = "DP-3 Goldstar Company";
  #           mode = "1920x1080@60Hz";
  #           # position = "x,y";
  #         }
  #       ];
  #     };
  #     tv = {
  #       # exec = [ "some command" ];
  #       outputs = [
  #         {
  #           criteria = "DP-1 Unknown Mi Monitor";
  #           mode = "3440x1440@144Hz";
  #           # position = "x,y";
  #         }
  #         {
  #           criteria = "DP-3 Goldstar Company";
  #           mode = "1920x1080@60Hz";
  #           # position = "x,y";
  #         }
  #       ];
  #     };
  #   };
  # };

  home.file = {
    "homescreenlayout" = {
      target = ".local/bin/homescreenlayout";
      executable = true;
      text =
        if useWayland
        then ''
          #!/usr/bin/env sh
          wlr-randr --output 'DP-1' --mode '3440x1440@144Hz' --output 'DP-3' --mode '1920x1080@60Hz' --pos '3440,170'
          swaybg -o 'DP-1' -m fill -i $HOME/MEGA/Wallpaper/dp-2_3.png -o 'DP-3' -m fill -i $HOME/MEGA/Wallpaper/cyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg &
        ''
        else ''
          #!/bin/sh
          #xrandr --output eDP-1 --primary --mode 2256x1504 --pos 0x1080 --rotate normal --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 168x0 --rotate normal --output DP-3 --off --output DP-4 --off
          feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png $HOME/MEGA/Wallpapercyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg
        '';
    };
    "tvlayout" = {
      target = ".local/bin/tvlayout";
      executable = true;
      text =
        if useWayland
        then ''
          #!/usr/bin/env sh
          wlr-randr --output 'DP-1' --mode '3440x1440@144Hz' --output 'DP-3' --mode '1920x1080@60Hz' --pos '3440,170'
          swaybg -o 'DP-1' -m fill -i $HOME/MEGA/Wallpaper/dp-2_3.png -o 'DP-3' -m fill -i $HOME/MEGA/Wallpaper/cyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg &
        ''
        else ''
          #!/bin/sh
          #xrandr --output eDP-1 --primary --mode 2256x1504 --pos 0x1080 --rotate normal --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 168x0 --rotate normal --output DP-3 --off --output DP-4 --off
          feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png $HOME/MEGA/Wallpapercyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg
        '';
    };
  };

  xsession = {
    initExtra = ''
      megasync &
      dwmblocks &
      feh --bg-center $HOME/MEGA/Wallpaper/ok_21-9.jpg $HOME/MEGA/Wallpaper/bonfire.jpg
    '';
  };
}
