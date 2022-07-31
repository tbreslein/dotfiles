{ config, pkgs, user, ... }:

let
  browser = "brave";
  mail = "thunderbird";
  editor = "nvim";
  visual = "nvim";
in
{
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "22.05";
    pointerCursor = {
      x11.enable = true;
      package = pkgs.quintom-cursor-theme;
      name = "quintom-cursor-theme";
    };
    sessionVariables = {
      BROWSER = browser;
      MAIL = mail;
      EDITOR = editor;
      VISUAL = visual;
    };
    shellAliases = {
      g = "git";
      lg = "lazygit";
      cp = "cp -i";
      rm = "rm -i";
      mv = "mv -i";
      ls = "exa";
      ll = "ls -lg --git";
      la = "ls -a";
      lla = "ll -a";
      lt = "ls --tree";
      v = editor;
      m = "make";
      nj = "ninja";
      emacs = "echo 'No.'";
      ssh = "TERM=xterm-256color ssh";
      hedisclang = "make clean full-clang build test";
      hedisgcc = "make clean full-gcc build test";
    };
  };

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;

    alacritty = {
      enable = true;
      window = {
        opacity = 0.85;
        padding = {
          x = 2;
          y = 2;
        };
      };

      font = {
        normal = {
          family = "Inconsolata";
          style = "Regular";
        };
      };
      schemes = {

        # gruvbox_hard_dark
        primary = {
          background = "#1d2021";
          foreground = "#ebdbb2";
        };
        normal = {
          black = "#3c3836";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#679d6a";
          white = "#a89984";
        };
        bright = {
          black = "#928374";
          red = "#fb4934";
          green = "#b8bb26";
          yellow = "#fabd2f";
          blue = "#83a598";
          magenta = "#d3869b";
          cyan = "#8ec07c";
          white = "#fbf1c7";
        };
        selection = {
          background = "#1d2021";
          foreground = "#ebdbb2";
        };
        indexed_colors = [
          {
            index = 16;
            color = "#fe8019";
          }
          {
            index = 17;
            color = "#fb4934";
          }
        ];
      };
    };

    lazygit.enable = true;
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

  # xsession = {
  #   enable = true;
  # };
}
