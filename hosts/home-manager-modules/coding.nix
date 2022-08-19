{ pkgs, shell, ... }:

{
  home = {
    packages = with pkgs; [
      # editors
      android-studio

      # tools
      hyperfine

      # formatting, linters, lsp
      cbfmt # code block formatting in markdown files
      editorconfig-core-c
      luaformatter
      nodePackages.bash-language-server
      nodePackages.cspell
      nodePackages.yaml-language-server
      selene # lua linter
      shellcheck
      shellharden
      sumneko-lua-language-server
      yamllint
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

        [*.{svelte,astro,mjs,cjs,ts,tsx,js,jsx,html,css,json,yml,yaml,nix}]
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
