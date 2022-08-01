{ config, pkgs, ... }:

{
  hardware.sane.enable = true;

  services = {
    avahi = {
      enable = true;
      publish = false;
    };
    printing.enable = true;
  };
  users.users.tommy.extraGroups = [ "lp" "scanner" ];
}
