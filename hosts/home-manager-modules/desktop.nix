{ pkgs, lib, font, colors, useWayland, homeDir, ... }:

let
  myColors = colors;
in
{
  home = {
    packages = with pkgs; [
      libnotify
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
      pasystray
      pavucontrol
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

    file = {
      "river-init-sh" = {
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
          riverctl map normal Super+Shift Return spawn 'bemenu-run -i --fn "Hack 18"'

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

          riverctl map normal Super Space toggle-float

          riverctl map normal Super F toggle-fullscreen

          # Super+L to lock the screen
          riverctl map normal Super+Control L spawn 'swaylock -c 000000'

          # screenshot all screens
          # riverctl map normal None Print spawn 'grim - | wl-copy'
          riverctl map normal None Print spawn 'slurp-screenshot fullscreen'

          # screenshot region
          # riverctl map normal Super Print spawn 'grim -g "$(slurp)" - | wl-copy'
          riverctl map normal Super Print spawn 'slurp-screenshot region'

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
              riverctl map $mode None XF86AudioRaiseVolume spawn 'pamixer --allow-boost -i 5'
              riverctl map $mode None XF86AudioLowerVolume spawn 'pamixer --allow-boost -d 5'
              riverctl map $mode None XF86AudioMute        spawn 'pamixer --toggle-mute'

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
          riverctl background-color 0x${colors.primary.background}
          riverctl border-color-focused 0x${colors.borders.focused}
          riverctl border-color-unfocused 0x${colors.borders.unfocused}
          riverctl border-width 1
          riverctl focus-follows-cursor disabled

          # Set keyboard repeat rate
          riverctl set-repeat 50 300

          # Make certain views start floating
          riverctl float-filter-add app-id float
          riverctl float-filter-add title "Picture in picture"

          # Set app-ids and titles of views which should use client side decorations
          riverctl csd-filter-add app-id "gedit"

          waybar &
          pasystray &
          mako &
          sleep 60 && megasync &

          # audron's screen layouts
          [[ $(cat /etc/hostname) == 'audron' ]] && sleep 0.1 && {
              # regular screen only
              [[ $(wlr-randr | grep 'Enabled: yes' | wc -l) -eq 1 ]] && singlescreenlayout

              # work screen layout
              [[ $(wlr-randr) =~ 'DELL U2711 ' ]] && workscreenlayout
          }

          # moebius' screen layouts
          [[ $(cat /etc/hostname) == 'moebius' ]] && sleep 0.1 && {
              # regular screens
              [[ $(wlr-randr | grep 'Enabled: yes' | wc -l) -eq 2 ]] && homescreenlayout

              # tv screen
              [[ $(wlr-randr) =~ 'Ltd 37LG7000 ' ]] && tvlayout
          }

          # Set the default layout generator to be rivertile and start it.
          # River will send the process group of the init executable SIGTERM on exit.
          riverctl default-layout rivertile
          rivertile -view-padding 3 -outer-padding 3 -main-ratio 0.65
        '';
      };
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
          # modules-left = [ "river/tags" ];
          # modules-center = [ "river/window" ];
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
      menu = "bemenu-run -i --fn 'Hack 18'";
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
        {
          command = "${pkgs.swayidle}/bin/swayidle -w timeout 300 '${pkgs.swaylock}/bin/swaylock -f -c 000000' timeout 150 '${pkgs.sway}/bin/swaymsg \"output * dpms off\"' resume '${pkgs.sway}/bin/swaymsg \"output * dpms on\"' before-sleep '${pkgs.swaylock}/bin/swaylock -f -c 000000'";
        }
        { command = "${pkgs.pasystray}/bin/pasystray"; }
        { command = "${pkgs.mako}/bin/mako"; }
        { command = "${pkgs.megasync}/bin/megasync"; }
        { command = "dbus-sway-environment"; }
        { command = "configure-gtk"; }
      ];
      input = {
        "type:touchpad" = { drag = "enabled"; dwt = "enabled"; scroll_method = "two_finger"; tap = "enabled"; };
      };
      modes = { }; # Unset default "resize" mode
      keybindings = lib.mkOptionDefault {
        "${modifier}+Shift+q" = "nop Unset default kill";
        "${modifier}+r" = "nop Unset default resize mode";
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
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer --allow-booster -i 5";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer --allow-booster -d 5";
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
