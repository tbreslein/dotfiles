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

  services.kanshi = {
    enable = useWayland;
    profiles = {
      undocked = {
        # exec = [ "some command" ];
        outputs = [
          {
            criteria = "eDP-1";
          }
        ];
      };
      home = {
        # exec = [ "some command" ];
        outputs = [
          {
            criteria = "eDP-1";
            mode = "2256x1504@60Hz";
            # position = "x,y";
          }
          {
            criteria = "DP-2";
            mode = "1920x1080";
            # position = "x,y";
          }
        ];
      };
      work = {
        # exec = [ "some command" ];
        outputs = [
          {
            criteria = "eDP-1";
            mode = "2256x1504@60Hz";
            # position = "x,y";
          }
          {
            criteria = "DP-2";
            mode = "1920x1080";
            # position = "x,y";
          }
        ];
      };
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
