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

  sound = {
    mediaKeys.enable = true;
  };
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 113 ]; events = [ "key" ]; command = "/home/tommy/.local/bin/dwm-volume t"; }
      { keys = [ 114 ]; events = [ "key" ]; command = "/home/tommy/.local/bin/dwm-volume d"; }
      { keys = [ 115 ]; events = [ "key" ]; command = "/home/tommy/.local/bin/dwm-volume i"; }
    ];
  };
}
