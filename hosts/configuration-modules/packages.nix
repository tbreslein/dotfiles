{ config, pkgs, homeDir, useWayland, ... }:

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

  nixpkgs.config.allowUnfree = true;

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
      rnix-lsp
      nixpkgs-fmt
      gnupg
      pinentry-curses
      (writeShellScriptBin "update-nixos" ''
        pushd ${homeDir}/.dotfiles && {
            git pull && \
                sudo nix flake update
                git diff --exit-code flake.lock 2&> /dev/null
                if [ $? -ne 0 ]; then
                    git add flake.lock && git commit -m 'update flake.lock'
                fi
                sudo nixos-rebuild --upgrade-all switch --impure --flake .#"$(cat /etc/hostname)"
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
    slock.enable = !useWayland;
  };
}
