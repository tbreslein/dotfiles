{ config, pkgs, useWayland, ... }:

{
  programs.alacritty.settings.font.size = 10;

  home.file = {
    "homescreenlayout" = {
      target = ".local/bin/homescreenlayout";
      executable = true;
      text =
        if useWayland
        then ''
          #!/usr/bin/env sh
          wlr-randr --output 'DP-1' --mode '3440x1440@144Hz' --output 'DP-3' --mode '1920x1080@60Hz' --pos '3440,170'
          swaybg -o 'DP-1' -m fill -i $HOME/MEGA/Wallpaper/ok_21-9.jpg -o 'DP-3' -m fill -i $HOME/MEGA/Wallpaper/bonfire.jpg &
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
          wlr-randr --output 'DP-1' --mode '3440x1440@144Hz' --pos '1920,0' --output 'DP-3' --mode '1920x1080@60Hz' --pos '5360,170' --output 'HDMI-A-1' --mode '1920x1080@60Hz' --pos '0,170'
          swaybg -o 'DP-1' -m fill -i $HOME/MEGA/Wallpaper/ok_21-9.jpg -o 'DP-3' -m fill -i $HOME/MEGA/Wallpaper/bonfire.jpg -o 'HDMI-A-1' -m fill -i $HOME/MEGA/Wallpaper/ok_16-9.jpg.jpg &
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
    '';
  };
}
