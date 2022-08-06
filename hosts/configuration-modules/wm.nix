{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager = {
      defaultSession = "none+dwm";
      lightdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "tommy";
    };
    windowManager.dwm.enable = true;
  };
  programs.hyprland.enable = true;
}
