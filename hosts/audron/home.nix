{ config, pkgs, ... }:

{
  programs = {
    alacritty.settings.font.size = 9;
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

  services.blueman-applet.enable = true;

  xsession = {
    initExtra = ''
      megasync &
      dwmblocks &
      birdtray &
      xset s 180 120
    '';
  };
}
