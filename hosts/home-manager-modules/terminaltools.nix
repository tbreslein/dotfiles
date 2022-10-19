{ pkgs, editor, shell, repoteer, ... }:

{
  home = {
    packages = [
      repoteer.packages.x86_64-linux.default
      pkgs.fd
      pkgs.freshfetch
      pkgs.imv
      pkgs.openfortivpn
      pkgs.pass
      pkgs.playerctl
      pkgs.pamixer
      pkgs.python3Minimal
      pkgs.ripgrep
      pkgs.trash-cli
      pkgs.zenith
      pkgs.wget
      pkgs.curl
      pkgs.gnutar
      pkgs.p7zip
      pkgs.unrar
      pkgs.zip
      pkgs.unzip
      pkgs.git
    ];
  };

  programs = {
    exa.enable = true;
    feh.enable = true;
    lazygit.enable = true;
    pandoc.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "base16-256";
      };
    };

    fzf = {
      enable = true;
      enableBashIntegration = "${shell}" == "bash";
      enableFishIntegration = "${shell}" == "fish";
      enableZshIntegration = "${shell}" == "zsh";
    };

    gh = {
      enable = true;
      settings.editor = editor;
    };

    git = {
      enable = true;
      userEmail = "tommy.breslein@protonmail.com";
      userName = "tbreslein";
      extraConfig = {
        push.default = "current";
        pull.rebase = true;
        core.editor = "${editor}";
      };
    };

    zoxide = {
      enable = true;
      enableBashIntegration = "${shell}" == "bash";
      enableFishIntegration = "${shell}" == "fish";
      enableZshIntegration = "${shell}" == "zsh";
    };
  };
}
