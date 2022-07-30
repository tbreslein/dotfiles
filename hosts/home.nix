{ config, pkgs, user, ... }:

{
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "22.05";
  };
  programs = {
    home-manager.enable = true;
    lazygit.enable = true;
    neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      withRuby = true;
      withPython3 = true;
      withNodeJs = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
