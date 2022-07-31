{ config, lib, pkgs, user, ... }:

let
  browser = "brave";
  mail = "thunderbird";
  editor = "nvim";
  visual = "nvim";
  shell = "fish";
  font = "Inconsolata";
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
      _JAVA_AWT_WM_NONREPARENTING = 1;
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
      btm = "btm -l";
      emacs = "echo 'No.'";
      ssh = "TERM=xterm-256color ssh";
      hedisclang = "make clean full-clang build test";
      hedisgcc = "make clean full-gcc build test";
    };

    packages = with pkgs; [
      thunderbird
      tdesktop
      libreoffice-fresh
      discord
      android-studio
      brave
      zoom-us
      birdtray
      megasync
      arandr
      libnotify
      scrot
      xclip
      xsel
      xss-lock
      slock
      pamixer
      nyxt

      ripgrep
      fd
      hyperfine
      imv
      pfetch
      openfortivpn
      playerctl

      editorconfig-core-c
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      shellcheck
      sumneko-lua-language-server

      dejavu_fonts
      inconsolata
      inconsolata-nerdfont
      liberation_ttf
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      noto-fonts-extra
      roboto
      ubuntu_font_family

    ];

    file = {
      scripts = {
        executable = true;
        recursive = true;
        source = ../scripts;
        target = ".local/bin/";
      };
      # nvimconfig = {
      #   recursive = false;
      #   source = ../config/nvim;
      #   target = ".config/nvim";
      # };
    };
  };

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;

    alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.85;
          padding = {
            x = 2;
            y = 2;
          };
        };

        font = {
          normal = {
            family = font;
            style = "Regular";
          };
        };
        colors = {

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
    };

    autorandr = {
      enable = true;
    };

    bat = {
      enable = true;
      config = {
        theme = "gruvbox-dark";
      };
    };

    bottom = {
      enable = true;
    };

    direnv = {
      enable = true;
      enableBashIntegration = shell == "bash";
      # enableFishIntegration = shell == "fish"; # gets loaded automatically anyways
      enableZshIntegration = shell == "zsh";
    };

    exa.enable = true;

    feh.enable = true;

    fish = {
      enable = shell == "fish";
      shellInit = ''
        fish_add_path $HOME/.local/bin
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
          name = "theme_gruvbox";
          src = pkgs.fetchFromGitHub
            {
              owner = "Jomik";
              repo = "fish-gruvbox";
              rev = "80a6f3a7b31beb6f087b0c56cbf3470204759d1c";
              sha256 = "vL2/Nm9Z9cdaptx8sJqbX5AnRtfd68x4ZKWdQk5Cngo=";
            };
        }
      ];
    };

    fzf = {
      enable = true;
      enableBashIntegration = shell == "bash";
      enableFishIntegration = shell == "fish";
      enableZshIntegration = shell == "zsh";
    };

    git = {
      enable = true;
      userEmail = "tommy.breslein@protonmail.com";
      userName = "tbreslein";
    };

    lazygit.enable = true;

    mpv.enable = true;

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

    nnn.enable = true;

    obs-studio.enable = true;

    pandoc.enable = true;

    starship = {
      enable = true;
      enableBashIntegration = shell == "bash";
      enableFishIntegration = shell == "fish";
      enableZshIntegration = shell == "zsh";
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

    zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
      };
    };
  };

  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          monitor = 0;
          width = 300;
          # height = 5;
          # offset = "-30x30";
          separator_height = 2;
          padding = 8;
          frame_width = 1;
          frame_color = "#ebdbb2";
          ide_treshold = 120;
          font = "${font} 11";

          icon_position = "left";
          min_icon_size = 0;
          max_icon_size = 32;
        };
        urgency_low = {
          background = "#1d2021";
          foreground = "#ebdbb2";
          timeout = 10;
        };
        urgency_normal = {
          background = "#1d2021";
          foreground = "#ebdbb2";
          timeout = 10;
        };
        urgency_critical = {
          background = "#1d1f28";
          foreground = "#dcd7ba";
          frame_color = "#fb4934";
          timeout = 0;
        };
      };
    };

    gammastep = {
      enable = true;
      provider = "geoclue2";
      temperature = {
        day = 5700;
        night = 3500;
      };
    };

    lorri.enable = true;
    network-manager-applet.enable = true;
    pasystray.enable = true;
    picom.enable = true;
  };

  xsession = {
    enable = true;
  };
}
