{ config, lib, pkgs, user, homeDir, colors, ... }:

let
  browser = "brave";
  browserPkg = pkgs.brave;
  mail = "thunderbird";
  mailPkg = pkgs.thunderbird;
  editor = "nvim";
  nvimPkg = pkgs.neovim;
  visual = "nvim";
  shell = "fish";
  font = "Hack";
in
{
  imports = [
    (import ./home-manager-modules/coding.nix { inherit pkgs shell; })
    (import ./home-manager-modules/desktop.nix { inherit pkgs lib font colors homeDir; })
    ./home-manager-modules/fonts.nix
    (import ./home-manager-modules/gui.nix { inherit pkgs colors; })
    (import ./home-manager-modules/neovim.nix { inherit pkgs nvimPkg; })
    (import ./home-manager-modules/shell.nix { inherit pkgs editor shell; })
    (import ./home-manager-modules/terminal.nix { inherit pkgs font colors; })
    (import ./home-manager-modules/terminaltools.nix { inherit pkgs editor shell; })
  ];

  # TEMP: upstream bug workaround
  manual.manpages.enable = false;

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
    };
  };
  services.blueman-applet.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.home-manager.enable = true;
  xsession = {
    enable = true;
    numlock.enable = true;
  };
}
