{ config, pkgs, homeDir, ... }:

{
  programs = {
    alacritty.settings.font.size = 9;

    autorandr.profiles = {
      "single" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0009e55f0900000000171d0104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a00fb";
        };
        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "2256x1504";
            rate = "60.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
        };
        hooks.postswitch = "feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png";
      };
      "work" = {
        fingerprint = {
          DP-2 = "00ffffffffffff0010ac56a04c4c333020150103803c2278ea8e05ad4f33b0260d5054a54b008100b300714fa9408180010101010101023a801871382d40582c250055502100001e000000ff00473630365431383530334c4c0a000000fc0044454c4c2055323731310a2020000000fd00384c1e5111000a2020202020200100020329f15090050403020716010611121513141f20230d7f0767030c001000382d830f0000e3050301023a801871382d40582c250055502100001e011d8018711c1620582c250055502100009e011d007251d01e206e28550055502100001e8c0ad08a20e02d10103e9600555021000018000000000000000000000000000068";
          eDP-1 = "00ffffffffffff0009e55f0900000000171d0104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a00fb";
        };
        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x1080";
            mode = "2256x1504";
            rate = "60.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
          DP-2 = {
            enable = true;
            crtc = 1;
            primary = false;
            position = "168x0";
            mode = "1920x1080";
            rate = "60.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
        };
        hooks.postswitch = "feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png $HOME/MEGA/Wallpaper/cyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg";
      };
      "home" = {
        fingerprint = {
          DP-2 = "00ffffffffffff0061a9443400000000101e0103805021782a64f5ad5049a322135054adcf00714f81c0814081809500a9c0b300d1c0216870a0d0a02950302035001d4e3100001a000000fd0030791eaa3c000a202020202020000000fc004d69204d6f6e69746f720a2020000000ffd03030303030303030303030303001ae020335f14c010203040590111213141f3f23090707830100006a030c001000383c20000067d85dc40178c003681a000001013079ed40d070a0d0a02950584045001d4e3100001ea348b86861a03250304035001d4e3100001ef57c70a0d0a02950302035001d4e3100001a565e00a0a0a02950302035001d4d3100001a000038";
          eDP-1 = "00ffffffffffff0009e55f0900000000171d0104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a00fb";
        };
        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "592x1440";
            mode = "2256x1504";
            rate = "60.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
          DP-2 = {
            enable = true;
            crtc = 1;
            primary = false;
            position = "0x0";
            mode = "3440x1440";
            rate = "60.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
        };
        hooks.postswitch = "feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png $HOME/MEGA/Wallpaper/cyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg";
      };
    };
  };
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
      autorandr -c
    '';
  };
}
