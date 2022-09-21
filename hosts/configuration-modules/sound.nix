{ config, pkgs, ... }:

{
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  users.users.tommy.extraGroups = [ "audio" ];
}
