{ config, pkgs, ... }:

{
  home.username = "tommy";
  home.homeDirectory = "/home/tommy";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}

