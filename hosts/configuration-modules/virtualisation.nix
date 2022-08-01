{ config, pkgs, ... }:

{
  # virt manager
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = [ pkgs.virt-manager ];
  users.users.tommy.extraGroups = [ "libvirtd" ];

  # docker
  virtualisation.docker = {
    rootless.enable = true;
    autoPrune.enable = true;
  };
  # users.users.tommy.extraGroups = [ "docker" ];
}
