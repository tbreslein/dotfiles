{ config, lib, pkgs, user, homeDir, colors, ... }:

let
  browser = "brave";
  browserPkg = pkgs.brave;
  mail = "thunderbird";
  mailPkg = pkgs.thunderbird;
  editor = "nvim";
  nvimPkg = pkgs.neovim-nightly;
  visual = "nvim";
  shell = "fish";
  font = "Hack";
in
{
  imports = [
    (import ./home-manager-modules/coding.nix { inherit pkgs shell; })
    (import ./home-manager-modules/desktop.nix { inherit pkgs lib font colors homeDir; })
    ./home-manager-modules/fonts.nix
    (import ./home-manager-modules/gui.nix { inherit pkgs colors; })
    (import ./home-manager-modules/neovim.nix { inherit pkgs nvimPkg; })
    (import ./home-manager-modules/shell.nix { inherit pkgs editor shell; })
    (import ./home-manager-modules/terminal.nix { inherit font colors; })
    (import ./home-manager-modules/terminaltools.nix { inherit pkgs editor shell; })
  ];

  # TEMP: upstream bug workaround
  manual.manpages.enable = false;

  home = {
    username = user;
    homeDirectory = homeDir;
    stateVersion = "22.05";

    pointerCursor = {
      x11 = {
        enable = true;
        defaultCursor = "X_cursor";
      };
      package = pkgs.quintom-cursor-theme;
      name = "Quintom_Ink";
    };

    sessionVariables = {
      BROWSER = browser;
      MAIL = mail;
      EDITOR = editor;
      VISUAL = visual;
      _JAVA_AWT_WM_NONREPARENTING = 1;
      DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/docker.sock";
    };

    file = {
      "zellij_config" = {
        target = ".config/zellij/config.kdl";
        executable = false;
        text = ''
          // If you'd like to override the default keybindings completely, be sure to change "keybinds" to "keybinds clear-defaults=true"
          keybinds {
              normal {
                  // uncomment this and adjust key if using copy_on_select=false
                  // bind "Alt c" { Copy; }
              }
              locked {
                  bind "Ctrl a" { SwitchToMode "Normal"; }
              }
              resize {
                  bind "Ctrl n" { SwitchToMode "Normal"; }
                  bind "h" "Left" { Resize "Left"; }
                  bind "j" "Down" { Resize "Down"; }
                  bind "k" "Up" { Resize "Up"; }
                  bind "l" "Right" { Resize "Right"; }
                  bind "=" "+" { Resize "Increase"; }
                  bind "-" { Resize "Decrease"; }
              }
              pane {
                  bind "Ctrl p" { SwitchToMode "Normal"; }
                  bind "h" "Left" { MoveFocus "Left"; }
                  bind "l" "Right" { MoveFocus "Right"; }
                  bind "j" "Down" { MoveFocus "Down"; }
                  bind "k" "Up" { MoveFocus "Up"; }
                  bind "p" { SwitchFocus; }
                  bind "n" { NewPane; SwitchToMode "Normal"; }
                  bind "d" { NewPane "Down"; SwitchToMode "Normal"; }
                  bind "r" { NewPane "Right"; SwitchToMode "Normal"; }
                  bind "x" { CloseFocus; SwitchToMode "Normal"; }
                  bind "f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
                  bind "z" { TogglePaneFrames; SwitchToMode "Normal"; }
                  bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
                  bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
                  bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0;}
              }
              move {
                  bind "Ctrl h" { SwitchToMode "Normal"; }
                  bind "n" "Tab" { MovePane; }
                  bind "h" "Left" { MovePane "Left"; }
                  bind "j" "Down" { MovePane "Down"; }
                  bind "k" "Up" { MovePane "Up"; }
                  bind "l" "Right" { MovePane "Right"; }
              }
              tab {
                  bind "Ctrl t" { SwitchToMode "Normal"; }
                  bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
                  bind "h" "Left" "Up" "k" { GoToPreviousTab; }
                  bind "l" "Right" "Down" "j" { GoToNextTab; }
                  bind "n" { NewTab; SwitchToMode "Normal"; }
                  bind "x" { CloseTab; SwitchToMode "Normal"; }
                  bind "s" { ToggleActiveSyncTab; SwitchToMode "Normal"; }
                  bind "1" { GoToTab 1; SwitchToMode "Normal"; }
                  bind "2" { GoToTab 2; SwitchToMode "Normal"; }
                  bind "3" { GoToTab 3; SwitchToMode "Normal"; }
                  bind "4" { GoToTab 4; SwitchToMode "Normal"; }
                  bind "5" { GoToTab 5; SwitchToMode "Normal"; }
                  bind "6" { GoToTab 6; SwitchToMode "Normal"; }
                  bind "7" { GoToTab 7; SwitchToMode "Normal"; }
                  bind "8" { GoToTab 8; SwitchToMode "Normal"; }
                  bind "9" { GoToTab 9; SwitchToMode "Normal"; }
                  bind "Tab" { ToggleTab; }
              }
              scroll {
                  bind "Ctrl s" { SwitchToMode "Normal"; }
                  bind "e" { EditScrollback; SwitchToMode "Normal"; }
                  bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
                  bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
                  bind "j" "Down" { ScrollDown; }
                  bind "k" "Up" { ScrollUp; }
                  bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
                  bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
                  bind "d" { HalfPageScrollDown; }
                  bind "u" { HalfPageScrollUp; }
                  // uncomment this and adjust key if using copy_on_select=false
                  // bind "Alt c" { Copy; }
              }
              search {
                  bind "Ctrl s" { SwitchToMode "Normal"; }
                  bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
                  bind "j" "Down" { ScrollDown; }
                  bind "k" "Up" { ScrollUp; }
                  bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
                  bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
                  bind "d" { HalfPageScrollDown; }
                  bind "u" { HalfPageScrollUp; }
                  bind "n" { Search "down"; }
                  bind "p" { Search "up"; }
                  bind "c" { SearchToggleOption "CaseSensitivity"; }
                  bind "w" { SearchToggleOption "Wrap"; }
                  bind "o" { SearchToggleOption "WholeWord"; }
              }
              entersearch {
                  bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
                  bind "Enter" { SwitchToMode "Search"; }
              }
              renametab {
                  bind "Ctrl c" { SwitchToMode "Normal"; }
                  bind "Esc" { UndoRenameTab; SwitchToMode "Tab"; }
              }
              renamepane {
                  bind "Ctrl c" { SwitchToMode "Normal"; }
                  bind "Esc" { UndoRenamePane; SwitchToMode "Pane"; }
              }
              session {
                  bind "Ctrl o" { SwitchToMode "Normal"; }
                  bind "Ctrl s" { SwitchToMode "Scroll"; }
                  bind "d" { Detach; }
              }
              tmux {
                  bind "[" { SwitchToMode "Scroll"; }
                  bind "Ctrl b" { Write 2; SwitchToMode "Normal"; }
                  bind "\"" { NewPane "Down"; SwitchToMode "Normal"; }
                  bind "%" { NewPane "Right"; SwitchToMode "Normal"; }
                  bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
                  bind "c" { NewTab; SwitchToMode "Normal"; }
                  bind "," { SwitchToMode "RenameTab"; }
                  bind "p" { GoToPreviousTab; SwitchToMode "Normal"; }
                  bind "n" { GoToNextTab; SwitchToMode "Normal"; }
                  bind "Left" { MoveFocus "Left"; SwitchToMode "Normal"; }
                  bind "Right" { MoveFocus "Right"; SwitchToMode "Normal"; }
                  bind "Down" { MoveFocus "Down"; SwitchToMode "Normal"; }
                  bind "Up" { MoveFocus "Up"; SwitchToMode "Normal"; }
                  bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
                  bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
                  bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
                  bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }
                  bind "o" { FocusNextPane; }
                  bind "d" { Detach; }
              }
              shared_except "locked" {
                  bind "Ctrl a" { SwitchToMode "Locked"; }
                  bind "Ctrl q" { Quit; }
                  bind "Alt n" { NewPane; }
                  bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
                  bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
                  bind "Alt j" "Alt Down" { MoveFocus "Down"; }
                  bind "Alt k" "Alt Up" { MoveFocus "Up"; }
                  bind "Alt =" "Alt +" { Resize "Increase"; }
                  bind "Alt -" { Resize "Decrease"; }
              }
              shared_except "normal" "locked" {
                  bind "Enter" "Space" "Esc" { SwitchToMode "Normal"; }
              }
              shared_except "pane" "locked" {
                  bind "Ctrl p" { SwitchToMode "Pane"; }
              }
              shared_except "resize" "locked" {
                  bind "Ctrl n" { SwitchToMode "Resize"; }
              }
              shared_except "scroll" "locked" {
                  bind "Ctrl s" { SwitchToMode "Scroll"; }
              }
              shared_except "session" "locked" {
                  bind "Ctrl o" { SwitchToMode "Session"; }
              }
              shared_except "tab" "locked" {
                  bind "Ctrl t" { SwitchToMode "Tab"; }
              }
              shared_except "move" "locked" {
                  bind "Ctrl h" { SwitchToMode "Move"; }
              }
              shared_except "tmux" "locked" {
                  bind "Ctrl b" { SwitchToMode "Tmux"; }
              }
          }

          plugins {
              tab-bar { path "tab-bar"; }
              status-bar { path "status-bar"; }
              strider { path "strider"; }
              compact-bar { path "compact-bar"; }
          }

          // Choose what to do when zellij receives SIGTERM, SIGINT, SIGQUIT or SIGHUP
          // eg. when terminal window with an active zellij session is closed
          // Options:
          //   - detach (Default)
          //   - quit
          //
          // on_force_close "quit"

          //  Send a request for a simplified ui (without arrow fonts) to plugins
          //  Options:
          //    - true
          //    - false (Default)
          simplified_ui true

          // Choose the path to the default shell that zellij will use for opening new panes
          // Default: $SHELL
          //
          // default_shell "fish"

          // Toggle between having pane frames around the panes
          // Options:
          //   - true (default)
          //   - false
          pane_frames false

          // Define color themes for Zellij
          // For more examples, see: https://github.com/zellij-org/zellij/tree/main/example/themes
          // Once these themes are defined, one of them should to be selected in the "theme" section of this file
          themes {
              gruvbox-dark {
                  fg 213 196 161
                  bg 40 40 40
                  black 60 56 54
                  red 204 36 29
                  green 152 151 26
                  yellow 215 153 33
                  blue 69 133 136
                  magenta 177 98 134
                  cyan 104 157 106
                  white 251 241 199
                  orange 214 93 14
              }
          }

          // Choose the theme that is specified in the themes section.
          // Default: default
          theme "gruvbox-dark"

          // The name of the default layout to load on startup
          // Default: "default"
          //
          // default_layout "compact"

          // Choose the mode that zellij uses when starting up.
          // Default: normal
          default_mode "locked"

          // Toggle enabling the mouse mode.
          // On certain configurations, or terminals this could
          // potentially interfere with copying text.
          // Options:
          //   - true (default)
          //   - false
          //
          // mouse_mode false

          // Configure the scroll back buffer size
          // This is the number of lines zellij stores for each pane in the scroll back
          // buffer. Excess number of lines are discarded in a FIFO fashion.
          // Valid values: positive integers
          // Default value: 10000
          //
          // scroll_buffer_size 10000

          // Provide a command to execute when copying text. The text will be piped to
          // the stdin of the program to perform the copy. This can be used with
          // terminal emulators which do not support the OSC 52 ANSI control sequence
          // that will be used by default if this option is not set.
          // Examples:
          //
          // copy_command "xclip -selection clipboard" // x11
          // copy_command "wl-copy"                    // wayland
          // copy_command "pbcopy"                     // osx

          // Choose the destination for copied text
          // Allows using the primary selection buffer (on x11/wayland) instead of the system clipboard.
          // Does not apply when using copy_command.
          // Options:
          //   - system (default)
          //   - primary
          //
          // copy_clipboard "primary"

          // Enable or disable automatic copy (and clear) of selection when releasing mouse
          // Default: true
          //
          // copy_on_select false

          // Path to the default editor to use to edit pane scrollbuffer
          // Default: $EDITOR or $VISUAL
          //
          // scrollback_editor "/usr/bin/vim"

          // When attaching to an existing session with other users,
          // should the session be mirrored (true)
          // or should each user have their own cursor (false)
          // Default: false
          //
          // mirror_session true

          // The folder in which Zellij will look for layouts
          //
          // layout_dir "/path/to/my/layout_dir"

          // The folder in which Zellij will look for themes
          //
          // theme_dir "/path/to/my/theme_dir"
        '';
      };
      "zellij_default_layout" = {
        target = ".config/zellij/layouts/default.kdl";
        executable = false;
        text = ''
          layout {
            pane size=1 borderless=true {
              plugin location="zellij:tab-bar"
            }
            pane
              pane size=2 borderless=true {
                plugin location="zellij:status-bar"
              }
          }
        '';
      };
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.home-manager.enable = true;
  xsession.enable = true;
}
