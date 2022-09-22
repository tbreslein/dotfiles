{ config, pkgs, useWayland, homeDir, ... }:

{
  programs.alacritty.settings.font.size = 16;
  services.blueman-applet.enable = true;

  home.file = {
    "singlescreenlayout" = {
      target = ".local/bin/singlescreenlayout";
      executable = true;
      text =
        if useWayland
        then ''
          #!/usr/bin/env sh
          wlr-randr --output "eDP-1" --mode "2256x1504" --scale "1.0"
          swaybg -o 'eDP-1' -m fill -i $HOME/MEGA/Wallpaper/ok_16-9.jpg &
        ''
        else ''
          #!/bin/sh
          xrandr --output eDP-1 --primary --mode 2256x1504
          feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png
        '';
    };
    "workscreenlayout" = {
      target = ".local/bin/workscreenlayout";
      executable = true;
      text =
        if useWayland
        then ''
          #!/usr/bin/env sh
          wlr-randr --output "eDP-1" --mode "2256x1504" --pos "0,1080" --scale "1.0" --output "DP-2" --mode "1920x1080@60Hz" --pos "170,0" --scale "1.0"
          swaybg -o 'eDP-1' -m fill -i $HOME/MEGA/Wallpaper/ok_16-9.jpg -o 'DP-2' -m fill -i $HOME/MEGA/Wallpaper/bonfire.jpg &
        ''
        else ''
          #!/bin/sh
          xrandr --output eDP-1 --primary --mode 2256x1504 --pos 0x1080 --rotate normal --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 168x0 --rotate normal --output DP-3 --off --output DP-4 --off
          feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png $HOME/MEGA/Wallpapercyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg
        '';
    };
  };

  xsession = {
    initExtra = ''
      megasync &
      dwmblocks &
      xset s 180 120
    '';
  };
}
