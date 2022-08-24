{ pkgs, nvimPkg, ... }:

{
  programs.neovim = {
    enable = true;
    package = nvimPkg;
    withNodeJs = true;
    withPython3 = true;
    extraPython3Packages = ps: with ps; [venvShellHook];
    withRuby = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
