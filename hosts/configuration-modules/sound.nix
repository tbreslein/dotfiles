{ config, pkgs, ... }:

{
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  users.users.tommy.extraGroups = [ "audio" ];
}
