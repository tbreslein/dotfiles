{ config, pkgs, homeDir, ... }:

{
  programs.alacritty.settings.font.size = 9;
  services.blueman-applet.enable = true;

  home.file = {
    "singlescreenlayout" = {
      target = ".local/bin/singlescreenlayout";
      executable = true;
      text = ''
        #!/bin/sh
        xrandr --output eDP-1 --primary --mode 2256x1504
        feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png
      '';
    };
    "homescreenlayout" = {
      target = ".local/bin/homescreenlayout";
      executable = true;
      text = ''
        #!/bin/sh
        xrandr --output eDP-1 --primary --mode 2256x1504
        feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png
      '';
    };
    "workscreenlayout" = {
      target = ".local/bin/workscreenlayout";
      executable = true;
      text = ''
        #!/bin/sh
        xrandr --output eDP-1 --primary --mode 2256x1504 --pos 0x1080 --rotate normal --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 168x0 --rotate normal --output DP-3 --off --output DP-4 --off
        feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png $HOME/MEGA/Wallpaper/cyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg
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
