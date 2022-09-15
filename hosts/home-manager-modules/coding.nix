{ pkgs, shell, ... }:

{
  home = {
    packages = with pkgs; [
      # compilers, builders, etc.
      gcc
      fennel
      gnumake
      nodejs

      # editors
      android-studio

      # tools
      hyperfine


      # formatting, linters, lsp
      # clojure
      clojure-lsp
      clj-kondo
      zprint

      # fennel
      fnlfmt

      # lua
      luaformatter
      sumneko-lua-language-server
      selene # lua linter

      # nix
      rnix-lsp
      nixpkgs-fmt
      statix

      # shell
      nodePackages.bash-language-server
      shellcheck
      shellharden

      # nodePackages.cspell
      nodePackages.yaml-language-server
      yamllint

      # misc
      cbfmt # code block formatting in markdown files
      editorconfig-core-c
    ];

    file.".editorconfig" = {
      target = ".editconfig";
      text = ''
        root = true

        [*]
        end_of_line = lf
        insert_final_newline = true
        charset = utf-8
        indent_style = space
        indent_size = 4

        [Makefile]
        indent_style = tab

        [*.{svelte,astro,mjs,cjs,ts,tsx,js,jsx,html,css,json,yml,yaml,nix,lua}]
        indent_size = 2
      '';
    };

  };

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = shell == "bash";
      # enableFishIntegration = shell == "fish"; # gets loaded automatically anyways
      enableZshIntegration = shell == "zsh";
      nix-direnv.enable = true;
    };
  };
}
