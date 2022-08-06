{ pkgs, editor, shell, ... }:

{
  home = {
    packages = with pkgs; [
      pass
      ripgrep
      fd
      imv
      pfetch
      openfortivpn
      playerctl
      pamixer
      python3Minimal
    ];
  };

  programs = {
    bottom.enable = true;
    exa.enable = true;
    feh.enable = true;
    lazygit.enable = true;
    nnn.enable = true;
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
