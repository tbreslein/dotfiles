{ config, lib, pkgs, user, homeDir, colors, useWayland, ... }:

let
  browser = "brave";
  browserPkg = pkgs.brave;
  mail = "thunderbird";
  mailPkg = pkgs.thunderbird;
  editor = "nvim";
  nvimPkg = pkgs.neovim-nightly;
  visual = "nvim";
  shell = "fish";
  font = "Hack";
in
{
  imports = [
    (import ./home-manager-modules/coding.nix { inherit pkgs shell; })
    (import ./home-manager-modules/desktop.nix { inherit pkgs lib font colors useWayland homeDir; })
    ./home-manager-modules/fonts.nix
    (import ./home-manager-modules/gui.nix { inherit pkgs colors useWayland; })
    (import ./home-manager-modules/neovim.nix { inherit pkgs nvimPkg; })
    (import ./home-manager-modules/shell.nix { inherit pkgs editor shell; })
    (import ./home-manager-modules/terminal.nix { inherit font colors; })
    (import ./home-manager-modules/terminaltools.nix { inherit pkgs editor shell; })
  ];

  home = {
    username = user;
    homeDirectory = homeDir;
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
      DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/docker.sock";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "wayland";
      #GTK_USE_PORTAL = if useWayland then 0 else "";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.home-manager.enable = true;
  xsession.enable = !useWayland;
}
