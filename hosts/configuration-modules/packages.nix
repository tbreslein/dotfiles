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
      gnumake
      fennel
      fnlfmt
      nodejs
      babashka
      wget
      curl
      gnutar
      p7zip
      unrar
      zip
      unzip
      git
      htop
      rnix-lsp
      nixpkgs-fmt
      statix
      gnupg
      pinentry-curses
      (writeShellScriptBin "update-nixos" ''
        pushd ${homeDir}/.dotfiles && {
            git pull && \
                sudo nix flake update
                sudo nixos-rebuild --upgrade-all switch --impure --flake .#"$(cat /etc/hostname)"
                nvim +PackerSync +TSUpdateSync
                booted="$(readlink /run/booted-system/{initrd,kernel,kernel-modules})"
                built="$(readlink /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules})"
                if [[ ! "$booted" == "$built" ]]; then
                    printf "\033[1;31minitrd or kernel packages have been rebuilt; reboot required!\033[0m"
                    echo ""
                fi
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

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  # };
}
