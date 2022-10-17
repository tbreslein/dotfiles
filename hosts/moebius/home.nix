{ config, pkgs, ... }:

{
  programs = {
    alacritty.settings.font.size = 10;
    autorandr.profiles = {
      "dual" = {
        fingerprint = {
          DisplayPort-0 = "";
          DisplayPort-2 = "";
        };
        config = {
          DisplayPort-0 = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "3440x1440";
            rate = "120.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
          DisplayPort-2 = {
            enable = true;
            primary = false;
            position = "3440x180";
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
      "tv" = {
        fingerprint = {
          DisplayPort-0 = "";
          DisplayPort-1 = "";
          DisplayPort-2 = "";
        };
        config = {
          DisplayPort-0 = {
            enable = true;
            primary = true;
            position = "1920x0";
            mode = "3440x1440";
            rate = "120.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
          DisplayPort-1 = {
            enable = true;
            primary = false;
            position = "0x180";
            mode = "1920x1080";
            rate = "60.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
          DisplayPort-2 = {
            enable = true;
            primary = false;
            position = "5360x180";
            mode = "1920x1080";
            rate = "60.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
        };
        hooks.postswitch = "feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png $HOME/MEGA/Wallpaper/cyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg $HOME/MEGA/Wallpaper/cyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg";
      };
    };
  };

  home.file = {
    "homescreenlayout" = {
      target = ".local/bin/homescreenlayout";
      executable = true;
      text = ''
        #!/bin/sh
        xrandr --output DisplayPort-0 --primary --mode 3440x1440 --rate '120.00' --pos 0x0 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --mode 1920x1080 --rate 60 --pos 3440x0 --rotate normal
        feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png $HOME/MEGA/Wallpaper/cyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg
      '';
    };
    "tvlayout" = {
      target = ".local/bin/tvlayout";
      executable = true;
      text = ''
        #!/bin/sh
        xrandr --output DisplayPort-0 --primary --mode 3440x1440 --rate '120.00' --pos 0x1080 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --mode 1920x1080 --rate 60 --pos 168x0 --rotate normal
        feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png $HOME/MEGA/Wallpaper/cyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg $HOME/MEGA/Wallpaper/ok_16-9.jpg
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
