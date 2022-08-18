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
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      user = "tommy";
      homeDir = "/home/${user}";

      useWayland = true;

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;

      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];

      deus = {
        primary= {
          background= "2c323b";
          foreground= "eaeaea";
          accent = "edbf69";
          alert = "ec3e45";
        };
        normal = {
          black = "242a32";
          red = "d54e53";
          green = "98c379";
          yellow = "e5c07b";
          blue = "83a598";
          magenta = "c678dd";
          cyan = "70c0ba";
          white = "eaeaea";
        };
        bright = {
          black = "666666";
          red = "ec3e45";
          green = "90c966";
          yellow = "edbf69";
          blue = "73ba9f";
          magenta = "c858e9";
          cyan = "2bcec2";
          white = "ffffff";
        };
        selection = {
          background = "2c323b";
          foreground = "eaeaea";
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
      };

      colors = tokyonight_storm;
    in
    {
      nixosConfigurations =
        (
          import ./hosts
            {
              inherit (nixpkgs) lib;
              inherit inputs user homeDir system overlays colors useWayland;
            }
        );
    };
}
