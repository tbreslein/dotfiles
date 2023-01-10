{
  description = "nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim-nightly-overlay = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    neovim-nightly-overlay = {
      url = "github:neovim/neovim?dir=contrib";
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

      colors = gruvbox_hard_dark;
    in
    {
      nixosConfigurations = import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs user homeDir system overlays colors;
      };
    };
}
