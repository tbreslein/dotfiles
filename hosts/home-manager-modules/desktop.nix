{ pkgs, font, colors, useWayland, ... }:

{
  home = {
    packages = (if useWayland
    then with pkgs; [
      wlr-randr
      grim
      slurp
      wl-clipboard
      swayidle
      swaylock-fancy
    ]
    else with pkgs; [
      arandr
      libnotify
      scrot
      xclip
      xsel
      xss-lock
    ]);
  };

  programs = {
    autorandr.enable = !useWayland;

    waybar = {
      enable = useWayland;

      #source: https://github.com/robertjk/dotfiles/blob/253b86442dae4d07d872e8b963fa33b5f8819594/.config/waybar/config
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          modules-left = [ "river/tags" "river/mode" ];
          modules-center = [ "river/window" ];
          modules-right = [ "pulseaudio" "cpu" "memory" "battery" "clock#date" "clock#time" "tray" ];
          "river/tags" = {
            tag-labels = [ "1.sh" "2.www" "3.mail" "4" "5" "6" "7" "8" "9" ];
          };
          "river/mode" = {
            format = " {} ";
          };
          "river/window" = {
            format = "{}";
            max-length = 120;
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
            format = " {usage}% ({load})";
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
            format = " {icon} {capacity}%";
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
            format = "{:%H:%M:%S}";
            tooltip = false;
          };
          "tray" = {
            icon-size = 21;
            spacing = 10;
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
                color: ${colors.primary.foreground};
            }

            to {
                color: ${colors.primary.foreground};
                background-color: ${colors.bright.yellow};
            }
        }

        @keyframes blink-critical {
            70% {
                color: ${colors.primary.foreground};
            }

            to {
                color: ${colors.primary.foreground};
                background-color: ${colors.primary.alert};
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
            background: ${colors.primary.background};
            color: ${colors.primary.foreground};
            font-family: Hack, Cantarell, Noto Sans, sans-serif;
            font-size: 10px;
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
            color: ${colors.bright.yellow};
        }

        #battery.critical {
            color: ${colors.primary.alert};
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
          /* No styles */
        }

        #cpu.warning {
            color: ${colors.bright.yellow};
        }

        #cpu.critical {
            color: ${colors.primary.alert};
        }

        #memory {
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        #memory.warning {
            color: ${colors.bright.yellow};
        }

        #memory.critical {
            color: ${colors.primary.alert};
            animation-name: blink-critical;
            animation-duration: 2s;
        }

        #mode {
            background: ${colors.bright.black};
            border-top: 2px solid ${colors.primary.foreground};
            /* To compensate for the top border and still have vertical centering */
            padding-bottom: 2px;
        }

        #network {
            /* No styles */
        }

        #network.disconnected {
            color: ${colors.bright.yellow};
        }

        #pulseaudio {
            /* No styles */
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
            color: ${colors.primary.alert};
        }

        #tray {
            /* No styles */
        }

        #window {
            font-weight: bold;
        }

        #tags button {
            border-top: 2px solid transparent;
            /* To compensate for the top border and still have vertical centering */
            padding-bottom: 2px;
            padding-left: 10px;
            padding-right: 10px;
            color: ${colors.bright.black};
        }

        #tags button.focused {
            border-color: ${colors.bright.magenta};
            color: ${colors.primary.foreground};
            background-color: ${colors.bright.black};
        }

        #tags button.occupied {
            color: ${colors.primary.foreground};
            background-color: ${colors.bright.black};
        }

        #tags button.urgent {
            border-color: ${colors.primary.alert};
            color: ${colors.primary.alert};
        }
      '';
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
          frame_color = colors.primary.foreground;
          ide_treshold = 120;
          font = "${font} 11";

          icon_position = "left";
          min_icon_size = 0;
          max_icon_size = 32;
        };
        urgency_low = {
          background = colors.primary.background;
          foreground = colors.primary.foreground;
          timeout = 10;
        };
        urgency_normal = {
          background = colors.primary.background;
          foreground = colors.primary.foreground;
          timeout = 10;
        };
        urgency_critical = {
          background = colors.primary.background;
          foreground = colors.primary.foreground;
          frame_color = colors.primary.alert;
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

    picom.enable = !useWayland;
  };
}
