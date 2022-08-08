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
      standard = {
        # exec = [ "some command" ];
        outputs = [
          {
            criteria = "DP-1 Unknown Mi Monitor";
            mode = "3440x1440@144Hz";
            # position = "x,y";
          }
          {
            criteria = "DP-3 Goldstar Company";
            mode = "1920x1080@60Hz";
            # position = "x,y";
          }
        ];
      };
      tv = {
        # exec = [ "some command" ];
        outputs = [
          {
            criteria = "DP-1 Unknown Mi Monitor";
            mode = "3440x1440@144Hz";
            # position = "x,y";
          }
          {
            criteria = "DP-3 Goldstar Company";
            mode = "1920x1080@60Hz";
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
