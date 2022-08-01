{ config, lib, pkgs, user, editor, shell, ... }:

{
  home = {
    packages = with pkgs; [
      ripgrep
      fd
      imv
      pfetch
      openfortivpn
      playerctl
      pamixer
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
        theme = "gruvbox-dark";
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
      push.default = true;
      pull.rebase = true;
      core.editor = "${editor}";
    };

    neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      withRuby = true;
      withPython3 = true;
      withNodeJs = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
