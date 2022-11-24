{ pkgs, editor, shell, ... }:

{
  home = {
    shellAliases = {
      g = "git";
      gg = "lazygit";
      cp = "cp -i";
      rm = "rm -i";
      mv = "mv -i";
      ls = "exa";
      ll = "ls -lg --git";
      la = "ls -a";
      lla = "ll -a";
      lt = "ls --tree";
      v = "${editor}";
      m = "make";
      nj = "ninja";
      s = "TERM=xterm-256color ssh";
      tcoding = "tmu a -t coding";
    };
  };

  programs = {
    fish = {
      enable = "${shell}" == "fish";
      shellInit = ''
        fish_add_path $HOME/.local/bin
        fish_add_path $HOME/.cargo/bin
        set -U fish_greeting
        fish_vi_key_bindings insert
      '';
      plugins = [
        {
          name = "done";
          src = pkgs.fetchFromGitHub
            {
              owner = "franciscolourenco";
              repo = "done";
              rev = "d6abb267bb3fb7e987a9352bc43dcdb67bac9f06";
              sha256 = "6oeyN9ngXWvps1c5QAUjlyPDQwRWAoxBiVTNmZ4sG8E=";
            };
        }
        {
          name = "fzf.fish";
          src = pkgs.fetchFromGitHub
            {
              owner = "PatrickF1";
              repo = "fzf.fish";
              rev = "c8c7d9903e0327b0d76e51ba4378ec8d5ef6477e";
              sha256 = "6oeyN9ngXWvps1c5QAUjlyPDQwRWAoxBiVTNmZ4sG8E=";
            };
        }
      ];
    };

    starship = {
      enable = true;
      enableBashIntegration = "${shell}" == "bash";
      enableFishIntegration = "${shell}" == "fish";
      enableZshIntegration = "${shell}" == "zsh";
      settings = {
        character = {
          success_symbol = "[λ](bold yellow)";
          error_symbol = "[✗](bold red)";
          vicmd_symbol = "[V](bold green)";
        };
        directory = {
          truncation_length = 7;
          truncate_to_repo = true;
        };
        hostname = {
          ssh_only = false;
          format = "[$hostname](bold bright-blue): ";
        };
      };
    };
  };
}
