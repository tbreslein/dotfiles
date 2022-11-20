{
  description = "nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # repoteer = {
    #   url = "github:tbreslein/repoteer";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      user = "tommy";
      homeDir = "/home/${user}";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      inherit (nixpkgs.lib) lib;

      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];

      gruvbox_material_hard_dark = {
        primary = {
          background = "1d2021";
          foreground = "d4be98";
          accent = "fe8019";
          alert = "fb4934";
        };
        normal = {
          black = "32302f";
          red = "ea6962";
          green = "a9b665";
          yellow = "d8a657";
          blue = "7daea3";
          magenta = "d3869b";
          cyan = "89b482";
          white = "d4be98";
        };
        bright = {
          black = "32302f";
          red = "ea6962";
          green = "a9b665";
          yellow = "d8a657";
          blue = "7daea3";
          magenta = "d3869b";
          cyan = "89b482";
          white = "d4be98";
        };
        selection = {
          background = "1d2021";
          foreground = "d4be98";
        };
        borders = {
          focused = "fe8019";
          unfocused = "1d2021";
        };
      };

      gruvbox_material_medium_dark = {
        primary = {
          background = "282828";
          foreground = "d4be98";
          accent = "fe8019";
          alert = "fb4934";
        };
        normal = {
          black = "3c3836";
          red = "ea6962";
          green = "a9b665";
          yellow = "d8a657";
          blue = "7daea3";
          magenta = "d3869b";
          cyan = "89b482";
          white = "d4be98";
        };
        bright = {
          black = "3c3836";
          red = "ea6962";
          green = "a9b665";
          yellow = "d8a657";
          blue = "7daea3";
          magenta = "d3869b";
          cyan = "89b482";
          white = "d4be98";
        };
        selection = {
          background = "282828";
          foreground = "d4be98";
        };
        borders = {
          focused = "fe8019";
          unfocused = "282828";
        };
      };

      gruvbox_material_soft_dark = {
        primary = {
          background = "32302f";
          foreground = "d4be98";
          accent = "fe8019";
          alert = "fb4934";
        };
        normal = {
          black = "45403d";
          red = "ea6962";
          green = "a9b665";
          yellow = "d8a657";
          blue = "7daea3";
          magenta = "d3869b";
          cyan = "89b482";
          white = "d4be98";
        };
        bright = {
          black = "45403d";
          red = "ea6962";
          green = "a9b665";
          yellow = "d8a657";
          blue = "7daea3";
          magenta = "d3869b";
          cyan = "89b482";
          white = "d4be98";
        };
        selection = {
          background = "32302f";
          foreground = "d4be98";
        };
        borders = {
          focused = "fe8019";
          unfocused = "32302f";
        };
      };

      gruvbox_hard_dark = {
        primary = {
          background = "1d2021";
          foreground = "ebdbb2";
          accent = "fe8019";
          alert = "fb4934";
        };
        normal = {
          black = "3c3836";
          red = "cc241d";
          green = "98971a";
          yellow = "d79921";
          blue = "458588";
          magenta = "b16286";
          cyan = "679d6a";
          white = "a89984";
        };
        bright = {
          black = "928374";
          red = "fb4934";
          green = "b8bb26";
          yellow = "fabd2f";
          blue = "83a598";
          magenta = "d3869b";
          cyan = "8ec07c";
          white = "fbf1c7";
        };
        selection = {
          background = "1d2021";
          foreground = "ebdbb2";
        };
        borders = {
          focused = "fe8019";
          unfocused = "1d2021";
        };
      };

      tokyonight_storm = {
        primary = {
          background = "24283b";
          foreground = "c0caf5";
          accent = "ff9e64";
          alert = "db4b4b";
        };
        normal = {
          black = "1d202f";
          red = "f7768e";
          green = "9ece6a";
          yellow = "e0af68";
          blue = "7aa2f7";
          magenta = "bb9af7";
          cyan = "7dcfff";
          white = "a9b1d6";
        };
        bright = {
          black = "414868";
          red = "f7768e";
          green = "9ece6a";
          yellow = "e0af68";
          blue = "7aa2f7";
          magenta = "bb9af7";
          cyan = "7dcfff";
          white = "c0caf5";
        };
        selection = {
          background = "24283b";
          foreground = "c0caf5";
        };
        borders = {
          focused = "ff9e64";
          unfocused = "1d202f";
        };
      };

      tokyonight_night = {
        primary = {
          background = "1a1b26";
          foreground = "c0caf5";
          accent = "ff9e64";
          alert = "db4b4b";
        };
        normal = {
          black = "414868";
          red = "f7768e";
          green = "9ece6a";
          yellow = "e0af68";
          blue = "7aa2f7";
          magenta = "bb9af7";
          cyan = "7dcfff";
          white = "a9b1d6";
        };
        bright = {
          black = "414868";
          red = "f7768e";
          green = "9ece6a";
          yellow = "e0af68";
          blue = "7aa2f7";
          magenta = "bb9af7";
          cyan = "7dcfff";
          white = "c0caf5";
        };
        selection = {
          background = "24283b";
          foreground = "c0caf5";
        };
        borders = {
          focused = "ff9e64";
          unfocused = "1d202f";
        };
      };

      catppuccin = {
        primary = {
          background = "1e1e2e";
          foreground = "cdd6f4";
          accent = "94e2d5";
          alert = "f38ba8";
        };
        normal = {
          black = "45465a";
          red = "f38ba8";
          green = "a6e3a1";
          yellow = "f9e2af";
          blue = "89b4fa";
          magenta = "f5c2e7";
          cyan = "94e2d5";
          white = "bac2de";
        };
        bright = {
          black = "585b70";
          red = "f38ba8";
          green = "a6e3a1";
          yellow = "f9e2af";
          blue = "89b4fa";
          magenta = "f5c2e7";
          cyan = "94e2d5";
          white = "a6adc8";
        };
        selection = {
          background = "f5e0dc";
          foreground = "1e1e2e";
        };
        borders = {
          focused = "94e2d5";
          unfocused = "6c7086";
        };
      };

      colors = gruvbox_hard_dark;
    in
    {
      nixosConfigurations = import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs user homeDir system overlays colors;
      };
    };
}
