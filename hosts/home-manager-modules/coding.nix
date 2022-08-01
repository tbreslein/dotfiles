{ pkgs, shell, ... }:

{
  home = {
    packages = with pkgs; [
      # editors
      android-studio

      # tools
      hyperfine

      # formatting, linters, lsp
      editorconfig-core-c
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      shellcheck
      sumneko-lua-language-server
    ];
  };

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = shell == "bash";
      # enableFishIntegration = shell == "fish"; # gets loaded automatically anyways
      enableZshIntegration = shell == "zsh";
    };
  };

  services = {
    lorri.enable = true;
  };
}
