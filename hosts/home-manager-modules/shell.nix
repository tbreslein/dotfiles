{ pkgs, editor, shell, ... }:

{
  home = {
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
      v = "${editor}";
      m = "make";
      nj = "ninja";
      btm = "btm -l";
      emacs = "echo 'No.'";
      ssh = "TERM=xterm-256color ssh";
      hedisclang = "make clean full-clang build test";
      hedisgcc = "make clean full-gcc build test";
      rldocker = "DOCKER_HOST=unix:///run/user/1000/docker.sock docker";
    };
  };

  programs = {
    fish = {
      enable = "${shell}" == "fish";
      shellInit = ''
        fish_add_path $HOME/.local/bin
        set -U fish_greeting
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
        hostname = {
          ssh_only = false;
          format = "[$hostname](bold bright-blue): ";
        };
        directory = {
          truncation_length = 7;
          truncate_to_repo = false;
        };
      };
    };

    tmux = {
      enable = true;
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.resurrect;
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-boot 'on'
            set -g @continuum-save-interval '30'
          '';
        }
      ];
      extraConfig = ''
        unbind C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*:Tc"
        set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
        set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
        set -g base-index 1
        setw -g pane-base-index 1
        set -sg escape-time 10; # make neovim not lag...
        set-option -g repeat-time 0 # disable key repeats
        set-window-option -g mode-keys vi
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
        bind -r k select-pane -U
        bind -r j select-pane -D
        bind -r h select-pane -L
        bind -r l select-pane -R
        bind C-x split-window -v
        bind C-v split-window -h
        bind C-n choose-tree
        bind q confirm-before -p "kill-pane #P? (y/n)" kill-pane
        bind w confirm-before -p "kill-window #P? (y/n)" kill-window
        bind-key m set-option -g mouse \; display "Mouse: #{?mouse,ON,OFF}"
        set -g mouse on
        set -g status-bg black
        set -g status-fg red
        set-window-option -g visual-bell on
        set-window-option -g bell-action other
        set -g window-status-current-style 'fg=yellow bg=black bold'
        set -g window-status-current-format ' [#I: #W] #[default]'
        set -g window-status-style 'fg=magenta bg=black'
        set -g window-status-format ' #I: #W #[default]'
        set -g status-interval 60
        set -g status-left-length 30
        # set -g status-left '#[fg=magenta](#S) #(whoami)@#(hostname) :: #[default]'
        set -g status-left 'Session: #S'
        # set -g status-right '#[fg=yellow]%H:%M#[default]'
        set -g status-right ' '
        set-option -g status-justify centre
      '';
    };
  };
}
