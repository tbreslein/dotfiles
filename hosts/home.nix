{ config, lib, pkgs, user, ... }:

let
  browser = "brave";
  browserPkg = pkgs.brave;
  mail = "thunderbird";
  mailPkg = pkgs.thunderbird;
  editor = "nvim";
  nvimPkg = pkgs.neovim-unwrapped;
  visual = "nvim";
  shell = "fish";
  font = "Inconsolata";
in
{
  imports = [
    (import ./home-manager-modules/coding.nix { inherit pkgs shell; })
    (import ./home-manager-modules/desktop.nix { inherit pkgs font; })
    ./home-manager-modules/fonts.nix
    (import ./home-manager-modules/gui.nix { inherit pkgs browserPkg mailPkg; })
    (import ./home-manager-modules/shell.nix { inherit pkgs editor shell; })
    (import ./home-manager-modules/terminal.nix { inherit font; })
    (import ./home-manager-modules/terminaltools.nix { inherit pkgs editor nvimPkg shell; })
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "22.05";

    pointerCursor = {
      x11 = {
        enable = true;
        defaultCursor = "X_cursor";
      };
      package = pkgs.quintom-cursor-theme;
      name = "Quintom_Ink";
    };

    sessionVariables = {
      BROWSER = browser;
      MAIL = mail;
      EDITOR = editor;
      VISUAL = visual;
      _JAVA_AWT_WM_NONREPARENTING = 1;
    };

    file = {
      scripts = {
        executable = true;
        recursive = true;
        source = ../scripts;
        target = ".local/bin/";
      };
      # nvimconfig = {
      #   recursive = false;
      #   source = ../config/nvim;
      #   target = ".config/nvim";
      # };
    };
  };

  programs.home-manager.enable = true;
  xsession.enable = true;
}
