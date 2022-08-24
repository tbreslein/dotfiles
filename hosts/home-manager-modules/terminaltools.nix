{ pkgs, editor, shell, ... }:

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
      sqlite
      trash-cli
      zenith
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
