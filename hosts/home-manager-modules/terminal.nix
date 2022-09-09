{ font, colors, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.95;
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
          # primary = {
          #   background = "#${colors.primary.background}";
          #   foreground = "#${colors.primary.foreground}";
          # };
          # normal = {
          #   black = "#${colors.normal.black}";
          #   red = "#${colors.normal.red}";
          #   green = "#${colors.normal.green}";
          #   yellow = "#${colors.normal.yellow}";
          #   blue = "#${colors.normal.blue}";
          #   magenta = "#${colors.normal.magenta}";
          #   cyan = "#${colors.normal.cyan}";
          #   white = "#${colors.normal.white}";
          # };
          # bright = {
          #   black = "#${colors.bright.black}";
          #   red = "#${colors.bright.red}";
          #   green = "#${colors.bright.green}";
          #   yellow = "#${colors.bright.yellow}";
          #   blue = "#${colors.bright.blue}";
          #   magenta = "#${colors.bright.magenta}";
          #   cyan = "#${colors.bright.cyan}";
          #   white = "#${colors.bright.white}";
          # };
          # selection = {
          #   background = "#${colors.selection.background}";
          #   foreground = "#${colors.selection.foreground}";
          # };
          # indexed_colors = [
          #   {
          #     index = 16;
          #     color = "#${colors.primary.accent}";
          #   }
          #   {
          #     index = 17;
          #     color = "#${colors.primary.alert}";
          #   }
          # ];
          primary = {
            background = "#1e1e2e";
            foreground = "#cdd6f4";
            dim_foreground = "#cdd6f4";
            bright_foreground = "#cdd6f4";
          };
          cursor = {
            text = "#1e1e2e";
            cursor = "#f5e0dc";
          };
          vi_mode_cursor = {
            text = "#1e1e2e";
            cursor = "#b4befe";
          };
          search = {
            matches = {
              foreground = "#1e1e2e";
              background = "#a6adc8";
            };
            focused_match = {
              foreground = "#1e1e2e";
              background = "#a6e3a1";
            };
            footer_bar = {
              foreground = "#1e1e2e";
              background = "#a6adc8";
            };
          };
          hints = {
            start = {
              foreground = "#1e1e2e";
              background = "#f9e2af";
            };
            end = {
              foreground = "#1e1e2e";
              background = "#a6adc8";
            };
          };
          normal = {
            black = "#45475a";
            red = "#f38ba8";
            green = "#a6e3a1";
            yellow = "#f9e2af";
            blue = "#b9b4fa";
            magenta = "#f5c2e7";
            cyan = "#94e2d5";
            white = "#bac2de";
          };
          bright = {
            black = "#585b70";
            red = "#f38ba8";
            green = "#a6e3a1";
            yellow = "#f9e2af";
            blue = "#b9b4fa";
            magenta = "#f5c2e7";
            cyan = "#94e2d5";
            white = "#a6adc8";
          };
          dim = {
            black = "#45475a";
            red = "#f38ba8";
            green = "#a6e3a1";
            yellow = "#f9e2af";
            blue = "#b9b4fa";
            magenta = "#f5c2e7";
            cyan = "#94e2d5";
            white = "#bac2de";
          };
          selection = {
            background = "#1e1e2e";
            foreground = "#f5e0dc";
          };
          indexed_colors = [
            {
              index = 16;
              color = "#fab387";
            }
            {
              index = 17;
              color = "#f5e0dc";
            }
          ];
        };
      };
    };
  };
}
