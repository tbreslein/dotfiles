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
      # terminal tools
      htop
      gnupg
      pinentry-curses
      (writeShellScriptBin "slurp-screenshot" ''
          # Credit: https://github.com/moverest/sway-interactive-screenshot/blob/master/sway-interactive-screenshot

          CHOICE=$1
          readonly SAVEDIR=${homeDir}/Pictures
          mkdir -p -- "$SAVEDIR"
          readonly FILENAME="$SAVEDIR/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')"

          case $CHOICE in
              fullscreen)
                  grim "$FILENAME"
                  ;;
              region)
                  grim -g "$(slurp)" "$FILENAME"
                  ;;
              "")
                  notify-send "Screenshot" "Cancelled"
                  exit 0
                  ;;
        esac

        wl-copy < "$FILENAME"
        notify-send "Screenshot" "File saved as <i>'$FILENAME'</i> and copied to the clipboard." -i $"FILENAME"
      '')
      (writeShellScriptBin "update-nixos" ''
        pushd ${homeDir}/.dotfiles && {
            git pull && \
            sudo nix flake update && \
            sudo nixos-rebuild --upgrade-all switch --flake .#"$(cat /etc/hostname)" && \
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
