{ pkgs, shell, ... }:

{
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        max_line_width = 120;
        indent_style = "space";
        indent_size = 2;
      };
      "Makefile" = {
        indent_style = "tab";
        indent_size = 4;
      };
      "*.{rs,c,cpp,h,hpp}" = {
        indent_size = 4;
      };
      "{CMakeLists.txt,*.cmake}" = {
        indent_size = 4;
      };
      ".f90" = {
        max_line_width = 72;
      };
    };
  };

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


      # fennel
      fnlfmt

      # nix
      rnix-lsp
      nixpkgs-fmt
      statix

      # shell
      nodePackages.bash-language-server
      shellcheck
      shellharden

      nodePackages.cspell
      nodePackages.prettier
      nodePackages.yaml-language-server
      yamllint

      # misc
      cbfmt # code block formatting in markdown files
      editorconfig-core-c
    ];
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
