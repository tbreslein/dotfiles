{ config, pkgs, ... }:

{
  # virt-manager
  virtualisation.virtualbox.host.enable = true;
  users.users.tommy.extraGroups = [ "vboxusers" ];

  # docker
  virtualisation.docker = {
    rootless.enable = true;
    autoPrune.enable = true;
  };
  environment.systemPackages = with pkgs; [ docker-compose ];
}
