{ config, pkgs, homeDir, ... }:

{
  nix = {
    package = pkgs.nixVersions.stable;
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
      htop
      gnupg
      pinentry-curses
      ntfs3g
      cmake
      gnumake
      gcc
      (writeShellScriptBin "backup-to-styx" ''
        rsync -a --info=progress2 ${homeDir}/work ganymedroot:/archive/admin/audron/$(date +%f)/
      '')
      (writeShellScriptBin "sync-from-styx" ''
        rsync -a --info=progress2 ganymedroot:/archive/admin/audron/$1 ${homeDir}/work/
      '')
      (writeShellScriptBin "update-nixos" ''
        pushd ${homeDir}/.dotfiles && {
            git pull && \
            sudo nix flake update && \
            if [[ ! -z $(git status --porcelain | grep flake.lock) ]]; then
                git add flake.lock
                git commit -m "update flake.lock"
                git push
            fi && \
            sudo nixos-rebuild --upgrade-all switch --flake .#"$(cat /etc/hostname)"
            if [[ ! "$(readlink /run/booted-system/{initrd,kernel,kernel-modules})" == "$(readlink /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules})" ]]; then
                printf "\033[1;31minitrd or kernel packages have been rebuilt; reboot required!\033[0m\n"
            fi
            if [ -d "~/.julia/environments/nvim-lspconfig" ]; then
              julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.update()'
            else
              julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
            fi
            julia -e 'using Pkg; Pkg.add(["Revise", "IJulia", "Makie", "CairoMakie", "Plots"]); Pkg.update()'
            nvim --headless -c 'autocmd User MasonUpdateAllComplete quitall' -c 'MasonUpdateAll'
            nvim -c 'lua require("lazy").sync()'
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
