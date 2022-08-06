{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager = {
      defaultSession = "none+dwm";
      sddm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "tommy";
    };
    windowManager.dwm.enable = true;
  };
}
