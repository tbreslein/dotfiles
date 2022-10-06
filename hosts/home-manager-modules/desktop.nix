{ pkgs, lib, font, colors, useWayland, homeDir, ... }:

let
  myColors = colors;
in
{
  home = {
    packages = with pkgs; [
      libnotify
      pasystray
      pavucontrol
    ] ++ (if useWayland
    then with pkgs; [
      swaybg
      wlr-randr
      wdisplays
      grim
      slurp
      wl-clipboard
      swayidle
      swaylock
      bemenu
      libappindicator
      (lua5_3.withPackages (ps: with ps; [ luaposix ]))
    ]
    else with pkgs; [
      arandr
      scrot
      xclip
      xsel
      xss-lock
      dmenu
    ]);

    sessionVariables = lib.mkIf useWayland {
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "wayland";
    };
  };

  programs = {
    autorandr.enable = !useWayland;

    mako = {
      enable = useWayland;
      backgroundColor = "#${myColors.primary.background}";
      borderColor = "#${myColors.borders.focused}";
      font = "${font} 10";
      height = 200;
    };

    waybar = {
      enable = useWayland;

      #source: https://github.com/robertjk/dotfiles/blob/253b86442dae4d07d872e8b963fa33b5f8819594/.config/waybar/config
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          modules-left = [ "sway/workspaces" "sway/mode" ];
          modules-center = [ "sway/window" ];
          modules-right = [ "pulseaudio" "cpu" "memory" "battery" "clock#date" "clock#time" "tray" ];
          "river/tags" = {
            tag-labels = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ];
          };
          "river/window" = {
            format = "{}";
            max-length = 60;
          };
          "pulseaudio" = {
            format = "{icon} {volume}%";
            format-bluetooth = "{icon} {volume}%";
            format-muted = "";
            format-icons = {
              headphones = "";
              default = [ "" "" ];
            };
          };
          "cpu" = {
            interval = 5;
            format = " {usage}%";
            states = {
              warning = 70;
              critical = 90;
            };
          };
          "memory" = {
            interval = 5;
            format = " {}%";
            states = {
              warning = 70;
              critical = 90;
            };
          };
          "battery" = {
            interval = 10;
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-discharging = "{icon} {capacity}%";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            tooltip = true;
          };
          "clock#date" = {
            interval = 1;
            format = " {:%e %b %Y}";
            tooltip-format = "{:%e %B %Y}";
          };
          "clock#time" = {
            interval = 1;
            format = "{:%H:%M}";
            tooltip = false;
          };
          "tray" = {
            icon-size = 21;
            spacing = 10;
          };
          "sway/mode" = {
            format = "<span style=\"italic\">  {}</span>";
            tooltip = false;
          };
          "sway/window" = {
            format = "{}";
            max-length = 60;
          };
          "sway/workspaces" = {
            all-outputs = false;
            disable-scroll = true;
            format = "{name}";
          };
        };
      };
      style = ''
        /* =============================================================================
         *
         * Waybar configuration
         *
         * Configuration reference: https://github.com/Alexays/Waybar/wiki/Configuration
         *
         * =========================================================================== */

        /* -----------------------------------------------------------------------------
         * Keyframes
         * -------------------------------------------------------------------------- */

        @keyframes blink-warning {
            70% {
                color: #${colors.primary.foreground};
            }

            to {
                color: #${colors.primary.foreground};
                background-color: #${colors.bright.yellow};
            }
        }

        @keyframes blink-critical {
            70% {
                color: #${colors.primary.foreground};
            }

            to {
                color: #${colors.primary.foreground};
                background-color: #${colors.primary.alert};
            }
        }


        /* -----------------------------------------------------------------------------
         * Base styles
         * -------------------------------------------------------------------------- */

        /* Reset all styles */
        * {
            border: none;
            border-radius: 0;
            min-height: 0;
            margin: 0;
            padding: 0;
        }

        /* The whole bar */
        #waybar {
            background: #${colors.primary.background};
            color: #${colors.primary.foreground};
            font-family: Hack, Cantarell, Noto Sans, sans-serif;
            font-size: 15px;
        }

        /* Each module */
        #battery,
        #clock,
        #cpu,
        #custom-keyboard-layout,
        #memory,
        #mode,
        #network,
        #pulseaudio,
        #temperature,
        #tray {
            padding-left: 10px;
            padding-right: 10px;
        }

        /* -----------------------------------------------------------------------------
         * Module styles
         * -------------------------------------------------------------------------- */

        #battery {
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        #battery.warning {
            color: #${colors.bright.yellow};
        }

        #battery.critical {
            color: #${colors.primary.alert};
        }

        #battery.warning.discharging {
            animation-name: blink-warning;
            animation-duration: 3s;
        }

        #battery.critical.discharging {
            animation-name: blink-critical;
            animation-duration: 2s;
        }

        #clock {
            font-weight: bold;
        }

        #cpu {
        }

        #cpu.warning {
            color: #${colors.bright.yellow};
        }

        #cpu.critical {
            color: #${colors.primary.alert};
        }

        #memory {
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        #memory.warning {
            color: #${colors.bright.yellow};
        }

        #memory.critical {
            color: #${colors.primary.alert};
            animation-name: blink-critical;
            animation-duration: 2s;
        }

        #mode {
            background: #${colors.bright.black};
            border-top: 2px solid #${colors.primary.foreground};
            /* To compensate for the top border and still have vertical centering */
            padding-bottom: 2px;
        }

        #network {
            /* No styles */
        }

        #network.disconnected {
            color: #${colors.bright.yellow};
        }

        #pulseaudio {
            border-left: 2px solid #${colors.primary.foreground};
        }

        #pulseaudio.muted {
            /* No styles */
        }

        #custom-spotify {
            color: rgb(102, 220, 105);
        }

        #temperature {
            /* No styles */
        }

        #temperature.critical {
            color: #${colors.primary.alert};
        }

        #tray {
            /* No styles */
        }

        #window {
            font-weight: bold;
        }

        #window.focused {
            color: #${colors.primary.accent}
        }

        #tags {
            border-right: 2px solid #${colors.primary.foreground};
        }

        #tags button {
            border-top: 2px solid transparent;
            /* To compensate for the top border and still have vertical centering */
            padding-bottom: 2px;
            padding-left: 10px;
            padding-right: 10px;
            color: #${colors.bright.black};
            background-color: #${colors.primary.background};
        }

        #tags button.focused {
            border-color: #${colors.primary.accent};
            color: #${colors.primary.foreground};
        }

        #tags button.occupied {
            color: #${colors.primary.foreground};
        }

        #tags button.urgent {
            border-color: #${colors.primary.alert};
            color: #${colors.primary.alert};
            background-color: #${colors.bright.black};
        }

        #workspaces {
            border-right: 2px solid #${colors.primary.foreground};
        }

        #workspaces button {
            border-top: 2px solid transparent;
            /* To compensate for the top border and still have vertical centering */
            padding-bottom: 2px;
            padding-left: 10px;
            padding-right: 10px;
            color: #${colors.bright.black};
            background-color: #${colors.primary.background};
        }

        #workspaces button.focused {
            border-color: #${colors.primary.accent};
            color: #${colors.primary.foreground};
        }

        #workspaces button.occupied {
            color: #${colors.primary.foreground};
        }

        #workspaces button.urgent {
            border-color: #${colors.primary.alert};
            color: #${colors.primary.alert};
            background-color: #${colors.bright.black};
        }
      '';
    };
  };

  services = {
    dunst = {
      enable = !useWayland;
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
      enable = !useWayland;
      provider = "geoclue2";
      temperature = {
        day = 5700;
        night = 3500;
      };
    };

    wlsunset = {
      enable = useWayland;
      latitude = "54.3";
      longitude = "10.1";
      temperature = {
        day = 5700;
        night = 3500;
      };
    };

    picom.enable = !useWayland;
  };

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "bemenu-run -i --fn 'Hack 15' -n";
      # bars = [{ command = "\${pkgs.waybar}/bin/waybar"; }];
      bars = [ ];
      colors = {
        background = "#${myColors.primary.background}";
        focused = {
          background = "#${myColors.primary.background}";
          border = "#${myColors.borders.focused}";
          childBorder = "#${myColors.borders.focused}";
          text = "#${myColors.primary.foreground}";
          indicator = "#${myColors.primary.foreground}";
        };
        unfocused = {
          background = "#${myColors.primary.background}";
          border = "#${myColors.borders.unfocused}";
          childBorder = "#${myColors.borders.unfocused}";
          text = "#${myColors.primary.foreground}";
          indicator = "#${myColors.primary.foreground}";
        };
        focusedInactive = {
          background = "#${myColors.primary.background}";
          border = "#${myColors.borders.unfocused}";
          childBorder = "#${myColors.borders.unfocused}";
          text = "#${myColors.primary.foreground}";
          indicator = "#${myColors.primary.foreground}";
        };
        urgent = {
          background = "#${myColors.primary.background}";
          border = "#${myColors.primary.alert}";
          childBorder = "#${myColors.primary.alert}";
          text = "#${myColors.primary.foreground}";
          indicator = "#${myColors.primary.foreground}";
        };
      };
      window.border = 1;
      floating = {
        border = 1;
        criteria = [
          { title = "Steam - Update News"; }
          { title = "Picture in picture"; }
          { class = "Pavucontrol"; }
        ];
      };
      focus = {
        followMouse = false;
        forceWrapping = false;
        mouseWarping = false;
      };
      fonts = {
        names = [ "Hack " ];
        size = 9.0;
        style = "Normal";
      };
      gaps.smartBorders = "on";
      startup = [
        { command = "waybar"; }
        # {
        #   command = "${pkgs.swayidle}/bin/swayidle -w timeout 300 '${pkgs.swaylock}/bin/swaylock -f -c 000000' timeout 150 '${pkgs.sway}/bin/swaymsg \"output * dpms off\"' resume '${pkgs.sway}/bin/swaymsg \"output * dpms on\"' before-sleep '${pkgs.swaylock}/bin/swaylock -f -c 000000'";
        # }
        { command = "${pkgs.pasystray}/bin/pasystray"; }
        { command = "${pkgs.mako}/bin/mako"; }
        { command = "sleep 60 && ${pkgs.megasync}/bin/megasync"; }
        { command = "dbus-sway-environment"; }
        { command = "configure-gtk"; }
      ];
      input = {
        "type:touchpad" = {
          drag = "enabled";
          dwt = "enabled";
          scroll_method = "two_finger";
          tap = "enabled";
        };
        "type:keyboard" = {
          repeat_delay = "300";
          repeat_rate = "30";
        };
      };
      # modes = { }; # Unset default "resize" mode
      keybindings = lib.mkOptionDefault {
        "${modifier}+Shift+q" = "nop Unset default kill";
        # "${modifier}+r" = "nop Unset default resize mode";
        "${modifier}+q" = "kill";
        "${modifier}+Control+r" = "reload";
        "${modifier}+Control+l" = "exec ${pkgs.swaylock}/bin/swaylock -f -c 000000";
        "${modifier}+Control+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
        "${modifier}+x" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+f" = "fullscreen";
        # "${modifier}+Space" = "floating toggle";
        # "${modifier}+Shift+Space" = "focus mode toggle";
        "Print" = "exec slurp-screenshot fullscreen";
        "Shift+Print" = "exec slurp-screenshot region";
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer --allow-boost -i 5";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer --allow-boost -d 5";
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer --toggle-mute";
        "XF86AudioMedia" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioMicMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
        "${modifier}+Alt+Left" = "move workspace to output left";
        "${modifier}+Alt+Right" = "move workspace to output right";
      };
    };
    # extraOptions = [ "--verbose" "--debug" "--unsupported-gpu" "--my-next-gpu-wont-be-nvidia" ];
    extraOptions = [ "--verbose" "--debug" ];
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    xwayland = true;
  };
}
