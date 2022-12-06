{ pkgs, lib, font, colors, homeDir, ... }:

let
  myColors = colors;
in
{
  home = {
    packages = with pkgs; [
      arandr
      dmenu
      libnotify
      pasystray
      pavucontrol
      scrot
      xclip
      xsel
      xss-lock
    ];
  };

  programs = {
    autorandr.enable = true;
    i3status-rust = {
      enable = true;
      bars = {
        top = {
          blocks = [
            { block = "focused_window"; }
            { block = "battery"; full_threshold = "60"; }
            { block = "cpu"; }
            { block = "memory"; }
            { block = "sound"; }
            { block = "time"; format = "%d-%m-%Y  %R"; }
          ];
        };
      };
      theme = "gruvbox-dark";
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
          frame_color = "#${colors.primary.foreground}";
          ide_treshold = 120;
          font = "${font} 11";

          icon_position = "left";
          min_icon_size = 0;
          max_icon_size = 32;
        };
        urgency_low = {
          background = "#${colors.primary.background}";
          foreground = "#${colors.primary.foreground}";
          timeout = 10;
        };
        urgency_normal = {
          background = "#${colors.primary.background}";
          foreground = "#${colors.primary.foreground}";
          timeout = 10;
        };
        urgency_critical = {
          background = "#${colors.primary.background}";
          foreground = "#${colors.primary.foreground}";
          frame_color = "#${colors.primary.alert}";
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

    picom.enable = true;
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      assigns = {
        "2: www" = [{ class = "^Brave-browser$"; }];
        "3: mail" = [{ class = "^thunderbird$"; }];
        "4" = [{ class = "^discord$"; }];
        "4" = [{ class = "^TelegramDesktop$"; }];
        "4" = [{ class = "^zoom$"; }];
      };
      floating.criteria = [
        { title = "Steam - Update News"; }
        { title = "Steam - Friends List"; }
        { title = "Picture in picture"; }
      ];
      focus.mouseWarping = false;
      modifier = "Mod4";
      keybindings =
        let modifier = config.xsession.windowManager.i3.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+Return" = "exec \${pkgs.alacritty}/bin/alacritty";
          "${modifier}+d" = ''exec \${pkgs.dmenu}/bin/dmenu_run -i -m 0 -fn Hack:size=12 -nb #${colors.primary.background} -nf #${colors.parimary.foreground} -sb #${colors.normal.black} -sf #${colors.primary.accent}'';
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Control+l" = "exec \${pkgs.slock}/bin/slock";
          "XF86AudioMute" = "pamixer -t";
          "XF86AudioLowerVolume" = "pamixer --allow-boost -d5";
          "XF86AudioRaiseVolume" = "pamixer --allow-boost -i5";
          "XF86AudioPlay" = "playerctl play-pause";
          "XF86AudioNext" = "playerctl next";
          "XF86AudioPrev" = "playerctl previous";
        };
      startup = [
        { command = "megasync"; }
        { command = "autorandr -c"; always = false; }
        { command = "xset m 1.5 1"; always = false; }
      ];
      terminal = "alacritty";
      window.border = 2;
      colors = {
        background = "#${colors.primary.background}";
        focused = {
          background = "#${colors.normal.black}";
          border = "#${colors.borders.focused}";
          childBorder = "#${colors.primary.foreground}";
          text = "#${colors.selection.foreground}";
        };
        focusedInactive = {
          background = "#${colors.primary.background}";
          border = "#${colors.borders.unfocused}";
          childBorder = "#${colors.normal.black}";
          text = "#${colors.primary.foreground}";
        };
        unfocused = {
          background = "#${colors.primary.background}";
          border = "#${colors.borders.unfocused}";
          childBorder = "#${colors.normal.black}";
          text = "#${colors.primary.foreground}";
        };
        urgent = {
          background = "#${colors.primary.foreground}";
          border = "#${colors.primary.alert}";
          childBorder = "#${colors.primary.alert}";
          text = "#${colors.primary.alert}";
        };
      };
      fonts = {
        names = [ "Hack" ];
        size = 12.0;
      };
      bars = [
        {
          position = "top";
          # statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
          fonts = {
            names = [ "Hack" ];
            size = 12.0;
          };
          # trayOutput = "primary";
          colors = {
            activeWorkspace = {
              background = "#${colors.primary.background}";
              border = "#${colors.primary.background}";
              text = "#${colors.primary.foreground}";
            };
            inactiveWorkspace = {
              background = "#${colors.primary.background}";
              border = "#${colors.primary.background}";
              text = "#${colors.primary.foreground}";
            };
            focusedWorkspace = {
              background = "#${colors.normal.black}";
              border = "#${colors.normal.black}";
              text = "#${colors.primary.accent}";
            };
            urgentWorkspace = {
              background = "#${colors.primary.foreground}";
              border = "#${colors.primary.foreground}";
              text = "#${colors.primary.alert}";
            };
            background = "#${colors.primary.background}";
            focusedBackground = "#${colors.normal.black}";
          };
        }
      ];
    };
  };
}
