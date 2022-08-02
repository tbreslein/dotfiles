{ config, pkgs, ... }:

let
  # can't I make this pure by using a relative path?
  # dwmConfigFile = ./config/dwm-config.h;
  # dwmblocksConfigFile = ./dwmblocks-config.h;

  configDir = "/home/tommy/.dotfiles/config";
  dwmConfigFile = "${configDir}/dwm-config.h";
  dwmblocksConfigFile = "${configDir}/dwmblocks-config.h";
in
{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (self: super: {
        dwm = super.dwm.overrideAttrs (oldAttrs: {
          # src = fetchFromGitHub {
          src = fetchGit {
            url = "https://github.com/tbreslein/dwm.git";
            ref = "build";
            rev = "1cc6df6cdf00a59c97028efec86a5ae1a5ecfcf0";
          };
          # postPatch = oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${super.writeText "config.h" (builtins.readFile "${dwmConfigFile}")} config.def.h";
        });
      })

      (self: super: {
        dwmblocks = super.dwmblocks.overrideAttrs (oldAttrs: {
          postPatch = oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${super.writeText "blocks.h" (builtins.readFile "${dwmblocksConfigFile}")} blocks.def.h";
        });
      })
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      vim
      st
      gcc
      wget
      curl
      gnutar
      p7zip
      unrar
      zip
      unzip
      git
      htop
      dmenu
      dwmblocks
      rnix-lsp
      nixpkgs-fmt
      gnupg
      pinentry-curses
    ];
  };

  programs = {
    gamemode.enable = true;
    # gnupg = {
    #   agent = {
    #     enable = true;
    #     pinentryFlavor = "gnome3";
    #   };
    # };
    npm = {
      enable = true;
      npmrc = ''
        prefix = $HOME/.npm
        init-license=BSD-3
        init-author=tbreslein
      '';
    };
    slock.enable = true;
  };
}
