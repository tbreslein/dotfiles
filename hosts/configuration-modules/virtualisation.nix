{ config, pkgs, ... }:

{
  # virt-manager
  virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  users.users.tommy.extraGroups = [ "vboxusers" ];

  # docker
  virtualisation.docker = {
    rootless.enable = true;
    autoPrune.enable = true;
  };
}
