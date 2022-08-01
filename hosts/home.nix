{ config, lib, pkgs, user, ... }:

let
  browser = "brave";
  mail = "thunderbird";
  editor = "nvim";
  visual = "nvim";
  shell = "fish";
  font = "Inconsolata";
in
{
  imports = [
    ./home-manager-modules/coding.nix
    (./home-manager-modules/desktop.nix { inherit font; })
    ./home-manager-modules/fonts.nix
    (./home-manager-modules/gui.nix { inherit browser mail; })
    (./home-manager-modules/shell.nix { inherit editor shell; })
    (./home-manager-modules/terminal.nix { inherit font; })
    (./home-manager-modules/terminaltools.nix { inherit editor shell; })
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "22.05";

    pointerCursor = {
      x11.enable = true;
      package = pkgs.quintom-cursor-theme;
      name = "quintom-cursor-theme";
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
