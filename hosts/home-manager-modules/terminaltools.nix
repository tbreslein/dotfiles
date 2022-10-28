{ pkgs, editor, shell, repoteer, ... }:

{
  home = {
    packages = with pkgs; [
      fd
      freshfetch
      imv
      openfortivpn
      pass
      playerctl
      pamixer
      python3Minimal
      ripgrep
      trash-cli
      zenith
      wget
      curl
      gnutar
      p7zip
      unrar
      zip
      unzip
      git
      tldr
      procs
      broot
    ] ++ [ repoteer.packages.x86_64-linux.default ];
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
