{ config, pkgs, user, neovim-nightly-overlays, ... }:

{
  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #   }))
  # ];
  home.username = "tommy";
  home.homeDirectory = "/home/tommy";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  programs = {
    neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      withRuby = true;
    };
  };
}
