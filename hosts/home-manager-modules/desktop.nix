{ pkgs, font, colors, useWayland, homeDir, ... }:

{
  home = {
    packages = (if useWayland
    then with pkgs; [
      swaybg
      wlr-randr
      wdisplays
      grim
      slurp
      wl-clipboard
      swayidle
      bemenu
      pasystray
      pavucontrol
      libappindicator
    ]
    else with pkgs; [
      arandr
      libnotify
      scrot
      xclip
      xsel
      xss-lock
      dmenu
    ]);

    file."river-init" = {
      target = ".config/river/init";
      executable = true;
      text = ''
        #!/bin/sh

        # This is the example configuration file for river.
        #
        # If you wish to edit this, you will probably want to copy it to
        # $XDG_CONFIG_HOME/river/init or $HOME/.config/river/init first.
        #
        # See the river(1), riverctl(1), and rivertile(1) man pages for complete
        # documentation.

        # Note: the "Super" modifier is also known as Logo, GUI, Windows, Mod4, etc.

        riverctl map normal Super Return spawn alacritty
        riverctl map normal Super+Shift Return spawn 'bemenu-run -i --fn "Hack 17" --tb "${colors.primary.background}" --fb "${colors.primary.background}" --nb "${colors.primary.background}" --ff "${colors.normal.cyan}"'

        # Super+Q to close the focused view
        riverctl map normal Super Q close

        # Super+Shift+E to exit river
        riverctl map normal Super+Shift E exit

        # Super+J and Super+K to focus the next/previous view in the layout stack
        riverctl map normal Super J focus-view next
        riverctl map normal Super K focus-view previous

        # Super+Shift+J and Super+Shift+K to swap the focused view with the next/previous
        # view in the layout stack
        riverctl map normal Super+Shift J swap next
        riverctl map normal Super+Shift K swap previous

        # Super+Period and Super+Comma to focus the next/previous output
        riverctl map normal Super Period focus-output next
        riverctl map normal Super Comma focus-output previous

        # Super+Shift+{Period,Comma} to send the focused view to the next/previous output
        riverctl map normal Super+Shift Period send-to-output next
        riverctl map normal Super+Shift Comma send-to-output previous

        # Super+Return to bump the focused view to the top of the layout stack
        riverctl map normal Super N zoom

        # Super+H and Super+L to decrease/increase the main ratio of rivertile(1)
        riverctl map normal Super H send-layout-cmd rivertile "main-ratio -0.05"
        riverctl map normal Super L send-layout-cmd rivertile "main-ratio +0.05"

        # Super+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
        riverctl map normal Super+Shift H send-layout-cmd rivertile "main-count +1"
        riverctl map normal Super+Shift L send-layout-cmd rivertile "main-count -1"

        # Super+Alt+{H,J,K,L} to move views
        riverctl map normal Super+Alt H move left 100
        riverctl map normal Super+Alt J move down 100
        riverctl map normal Super+Alt K move up 100
        riverctl map normal Super+Alt L move right 100

        # Super+Alt+Control+{H,J,K,L} to snap views to screen edges
        riverctl map normal Super+Alt+Control H snap left
        riverctl map normal Super+Alt+Control J snap down
        riverctl map normal Super+Alt+Control K snap up
        riverctl map normal Super+Alt+Control L snap right

        # Super+Alt+Shift+{H,J,K,L} to resize views
        riverctl map normal Super+Alt+Shift H resize horizontal -100
        riverctl map normal Super+Alt+Shift J resize vertical 100
        riverctl map normal Super+Alt+Shift K resize vertical -100
        riverctl map normal Super+Alt+Shift L resize horizontal 100

        # Super + Left Mouse Button to move views
        riverctl map-pointer normal Super BTN_LEFT move-view

        # Super + Right Mouse Button to resize views
        riverctl map-pointer normal Super BTN_RIGHT resize-view

        for i in $(seq 1 9)
        do
            tags=$((1 << ($i - 1)))

            # Super+[1-9] to focus tag [0-8]
            riverctl map normal Super $i set-focused-tags $tags

            # Super+Shift+[1-9] to tag focused view with tag [0-8]
            riverctl map normal Super+Shift $i set-view-tags $tags

            # Super+Ctrl+[1-9] to toggle focus of tag [0-8]
            riverctl map normal Super+Control $i toggle-focused-tags $tags

            # Super+Shift+Ctrl+[1-9] to toggle tag [0-8] of focused view
            riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
        done

        # Super+0 to focus all tags
        # Super+Shift+0 to tag focused view with all tags
        all_tags=$(((1 << 32) - 1))
        riverctl map normal Super 0 set-focused-tags $all_tags
        riverctl map normal Super+Shift 0 set-view-tags $all_tags

        # Super+Space to toggle float
        riverctl map normal Super Space toggle-float

        # Super+F to toggle fullscreen
        riverctl map normal Super F toggle-fullscreen

        # Super+L to lock the scree
        riverctl map normal Super+Control L spawn swaylock -c 000000

        # Super+{Up,Right,Down,Left} to change layout orientation
        riverctl map normal Super Up    send-layout-cmd rivertile "main-location top"
        riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
        riverctl map normal Super Down  send-layout-cmd rivertile "main-location bottom"
        riverctl map normal Super Left  send-layout-cmd rivertile "main-location left"

        # Declare a passthrough mode. This mode has only a single mapping to return to
        # normal mode. This makes it useful for testing a nested wayland compositor
        riverctl declare-mode passthrough

        # Super+F11 to enter passthrough mode
        riverctl map normal Super F11 enter-mode passthrough

        # Super+F11 to return to normal mode
        riverctl map passthrough Super F11 enter-mode normal

        # Various media key mapping examples for both normal and locked mode which do
        # not have a modifier
        for mode in normal locked
        do
            # Eject the optical drive (well if you still have one that is)
            #riverctl map $mode None XF86Eject spawn 'eject -T'

            # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
            riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
            riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5'
            riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute'

            # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
            riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
            riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
            riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
            riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

            # Control screen backlight brightness with light (https://github.com/haikarainen/light)
            #riverctl map $mode None XF86MonBrightnessUp   spawn 'light -A 5'
            #riverctl map $mode None XF86MonBrightnessDown spawn 'light -U 5'
        done

        # Set background and border color
        riverctl background-color 0x1a1b26
        riverctl border-color-focused 0x7dcfff
        riverctl border-color-unfocused 0x414868

        # Set keyboard repeat rate
        riverctl set-repeat 50 300

        # Make certain views start floating
        riverctl float-filter-add app-id float
        riverctl float-filter-add title "popup title with spaces"

        # Set app-ids and titles of views which should use client side decorations
        riverctl csd-filter-add app-id "gedit"

        waybar &
        pasystray &

        bash -c "[[ $(cat /etc/hostname) == 'audron' ]] && swaybg -o 'eDP-1' -m fill -i ${homeDir}/MEGA/Wallpaper/helloworld.jpeg -o 'DP-2' -m fill -i ${homeDir}/MEGA/Wallpaper/cup-o-cats-blueish.png &"

        # Set the default layout generator to be rivertile and start it.
        # River will send the process group of the init executable SIGTERM on exit.
        riverctl default-layout rivertile
        rivertile -view-padding 0 -outer-padding 0
      '';
    };
  };

  programs = {
    autorandr.enable = !useWayland;

    mako = {
      enable = useWayland;
      backgroundColor = colors.primary.background;
      borderColor = colors.primary.accent;
      font = "${font} 13";
    };

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
            background-color: ${colors.primary.background};
        }

        #tags button.focused {
            border-color: ${colors.primary.accent};
            color: ${colors.primary.foreground};
        }

        #tags button.occupied {
            color: ${colors.primary.foreground};
        }

        #tags button.urgent {
            border-color: ${colors.primary.alert};
            color: ${colors.primary.alert};
            background-color: ${colors.bright.black};
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
}
