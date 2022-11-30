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
      tcoding = "tmux a -t coding";
    };
  };

  programs = {
    fish = {
      enable = true;
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

    nushell = {
      enable = true;
      configFile.source = ../../configs/nushell/config.nu;
      envFile.source = ../../configs/nushell/env.nu;
    };

    starship = {
      enable = true;
      enableNushellIntegration = false; # TEMP
      settings = {
        add_newline = true;
        battery.display.threshold = 30;
        character = {
          success_symbol = "[λ](bold yellow)";
          error_symbol = "[✗](bold red)";
          vicmd_symbol = "[V](bold green)";
        };
        directory = {
          fish_style_pwd_dir_length = 1;
          truncate_to_repo = false;
          style = "bold blue";
        };
        format = "$directory\\[ $git_branch$git_commit$git_state$git_metrics$git_status\\]$line_break$time$nix_shell$character";
        git_branch.format = "[$branch(:$remote_branch)]($style) ";
        nix_shell.format = "[$symbol]($style)";
        time = {
          disabled = false;
          format = "[$time]($style) ";
        };
      };
    };
  };
}
