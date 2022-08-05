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

          # gruvbox_hard_dark
          primary = {
            background = colors.primary.background;
            foreground = colors.primary.foreground;
          };
          normal = colors.normal;
          bright = colors.bright;
          selection = colors.selection;
          indexed_colors = [
            {
              index = 16;
              color = colors.primary.accent;
            }
            {
              index = 17;
              color = colors.primary.alert;
            }
          ];
        };
      };
    };
  };
}
