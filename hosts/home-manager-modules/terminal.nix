{ config, lib, pkgs, user, font, ... }:

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
  };
}
