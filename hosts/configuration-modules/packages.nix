{ config, pkgs, homeDir, ... }:

let
  # can't I make this pure by using a relative path?
  # dwmConfigFile = ./config/dwm-config.h;
  # dwmblocksConfigFile = ./dwmblocks-config.h;

  configDir = "${homeDir}/.dotfiles/config";
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
          src = fetchFromGitHub {
            owner = "tbreslein";
            repo = "dwm";
            rev = "1d3c7ce710187634b52c86a2694cd6ae54a18bf6";
            sha256 = "6oeyN9ngXWvps1c5QAUjlyPDQwRWAoxBiVTNmZ4sG8E=";
          };
        });
      })

      # (self: super: {
      #   dwmblocks = super.dwmblocks.overrideAttrs (oldAttrs: {
      #     postPatch = oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${super.writeText "blocks.h" (builtins.readFile "${dwmblocksConfigFile}")} blocks.def.h";
      #   });
      # })

      (self: super: {
        dwmblocks = super.dwm.overrideAttrs (oldAttrs: {
          src = fetchFromGitHub {
            owner = "tbreslein";
            repo = "dwmblocks";
            rev = "37bb6fc7c20c8c2746a0c708d96c8a805cb73637";
            sha256 = "6oeyN9ngXWvps1c5QAUjlyPDQwRWAoxBiVTNmZ4sG8E=";
          };
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
      (writeShellScriptBin "update-nixos" ''
        rm -f "${homeDir}/.config/nvim/init.vim" && \
            pushd ${homeDir}/.dotfiles && {
                git pull && \
                    sudo nix flake update
                    git diff --exit-code flake.lock 2&> /dev/null
                    if [ $? -ne 0 ]; then
                        git add flake.lock && git commit -m 'update flake.lock'
                    fi
                    sudo nixos-rebuild --upgrade-all switch --impure --flake .#"$(cat /etc/hostname)"
                    rm -f "${homeDir}/.config/nvim/init.vim" && \
                    nvim -c 'PackerSync' -c 'TSUpdateSync'
            }
            popd || exit
      '')
    ];
  };

  programs = {
    gamemode.enable = true;
    npm = {
      enable = true;
      npmrc = ''
        prefix = ${homeDir}/.npm
        init-license=BSD-3
        init-author=tbreslein
      '';
    };
    slock.enable = true;
  };
}
