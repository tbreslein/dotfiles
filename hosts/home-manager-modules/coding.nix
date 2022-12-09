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
      gnumake
      nodejs
      cargo
      luajitPackages.luarocks
      go
      just
      (python310.withPackages (ps: with ps; with python310Packages; [
        pip
      ]))

      # editors
      android-studio

      # tools
      hyperfine
      editorconfig-core-c
      nixpkgs-fmt
      statix
      stylua
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
