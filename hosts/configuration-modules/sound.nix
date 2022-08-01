{ config, pkgs, ... }:

{
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware.pulseaudio.enable = true;
  users.users.tommy.extraGroups = [ "audio" ];
}
