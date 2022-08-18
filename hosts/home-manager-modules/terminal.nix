{ font, colors, ... }:

{
  programs = {
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

          primary = {
            background = "#${colors.primary.background}";
            foreground = "#${colors.primary.foreground}";
          };
          normal = {
            black = "#${colors.normal.black}";
            red = "#${colors.normal.red}";
            green = "#${colors.normal.green}";
            yellow = "#${colors.normal.yellow}";
            blue = "#${colors.normal.blue}";
            magenta = "#${colors.normal.magenta}";
            cyan = "#${colors.normal.cyan}";
            white = "#${colors.normal.white}";
          };
          bright = {
            black = "#${colors.bright.black}";
            red = "#${colors.bright.red}";
            green = "#${colors.bright.green}";
            yellow = "#${colors.bright.yellow}";
            blue = "#${colors.bright.blue}";
            magenta = "#${colors.bright.magenta}";
            cyan = "#${colors.bright.cyan}";
            white = "#${colors.bright.white}";
          };
          selection = {
            background = "#${colors.selection.background}";
            foreground = "#${colors.selection.foreground}";
          };
          indexed_colors = [
            {
              index = 16;
              color = "#${colors.primary.accent}";
            }
            {
              index = 17;
              color = "#${colors.primary.alert}";
            }
          ];
        };
      };
    };
  };
}
