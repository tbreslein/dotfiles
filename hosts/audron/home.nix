{ config, pkgs, useWayland, homeDir, ... }:

{
  programs = {
    alacritty.settings.font.size = 13;
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

  services = {
    blueman-applet.enable = true;

    # kanshi = {
    #   enable = false;
    #   profiles = {
    #     undocked = {
    #       outputs = [
    #         {
    #           criteria = "eDP-1";
    #         }
    #       ];
    #     };
    #     # home = {
    #     #   # exec = [ "some command" ];
    #     #   outputs = [
    #     #     {
    #     #       criteria = "eDP-1";
    #     #       mode = "2256x1504";
    #     #       # position = "x,y";
    #     #     }
    #     #     {
    #     #       criteria = "*DELL U2711*";
    #     #       mode = "1920x1080";
    #     #       # position = "x,y";
    #     #     }
    #     #   ];
    #     # };
    #     work = {
    #       outputs = [
    #         {
    #           criteria = "eDP-1";
    #           mode = "2256x1504";
    #           position = "0,1080";
    #         }
    #         {
    #           criteria = "*DELL U2711*";
    #           mode = "1920x1080@60Hz";
    #           position = "170,0";
    #         }
    #       ];
    #     };
    #   };
    # };
  };

  home.file."workscreenlayout" = {
    target = ".local/bin/workscreenlayout";
    executable = true;
    text =
      if useWayland
      then ''
        #!/usr/bin/env sh
        wlr-randr --output "eDP-1" --mode "2256x1504" --pos "0,1080" --output "DP-2" --mode "1920x1080@60Hz" --pos "170,0"
        swaybg -o 'eDP-1' -m fill -i ${homeDir}/MEGA/Wallpaper/helloworld.jpeg -o 'DP-2' -m fill -i ${homeDir}/MEGA/Wallpaper/cup-o-cats-blueish.png &
      ''
      else ''
        #!/bin/sh
        xrandr --output eDP-1 --primary --mode 2256x1504 --pos 0x1080 --rotate normal --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 168x0 --rotate normal --output DP-3 --off --output DP-4 --off
        feh --bg-fill $HOME/MEGA/Wallpaper/helloworld.jpeg $HOME/MEGA/Wallpaper/cup-o-cats-blueish.png
      '';
  };

  xsession = {
    initExtra = ''
      megasync &
      dwmblocks &
      xset s 180 120
    '';
  };
}
