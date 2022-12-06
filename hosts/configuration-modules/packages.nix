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
      (writeshellscriptbin "backup-to-styx" ''
        rsync -a --info=progress2 ${homedir}/work ganymedroot:/archive/admin/audron/$(date +%f)/
      '')
      (writeshellscriptbin "sync-from-styx" ''
        rsync -a --info=progress2 ganymedroot:/archive/admin/audron/$1 ${homedir}/work/
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
            sudo nixos-rebuild --upgrade-all switch --flake .#"$(cat /etc/hostname)" && \
            if [[ ! "$(readlink /run/booted-system/{initrd,kernel,kernel-modules})" == "$(readlink /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules})" ]]; then
                printf "\033[1;31minitrd or kernel packages have been rebuilt; reboot required!\033[0m\n"
            fi && \
            nvim +PackerSync +TSUpdateSync
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
