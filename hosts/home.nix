{ config, lib, pkgs, user, homeDir, colors, ... }:

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
    (import ./home-manager-modules/desktop.nix { inherit pkgs font colors; })
    ./home-manager-modules/fonts.nix
    (import ./home-manager-modules/gui.nix { inherit pkgs colors; })
    (import ./home-manager-modules/shell.nix { inherit pkgs editor shell; })
    (import ./home-manager-modules/terminal.nix { inherit font colors; })
    (import ./home-manager-modules/terminaltools.nix { inherit pkgs editor nvimPkg shell; })
  ];

  home = {
    username = user;
    homeDirectory = homeDir;
    stateVersion = "22.05";

    activation = {
      link_nvimconfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD ln -sf $VERBOSE_ARG \
          ${builtins.toPath ../config/nvim} $HOME/config/nvim
      '';

      # because for some reason home manager HAS to add an init.vim
      remove_initvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD rm -f $VERBOSE_ARG ${builtins.toPath ../config/nvim/init.vim}
      '';
    };

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

    # file = {
    # nvimconfig = {
    #   recursive = false;
    #   source = ../config/nvim;
    #   target = ".config/nvim";
    # };
    # };
  };

  programs.home-manager.enable = true;
  xsession.enable = true;
}
