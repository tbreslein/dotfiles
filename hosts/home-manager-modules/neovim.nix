{ pkgs, nvimPkg, ... }:

{
  programs.neovim = {
    enable = true;
    package = nvimPkg;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
