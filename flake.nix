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

  outputs = inputs@{ self, nixpkgs, home-manager, neovim-nightly-overlay, ... }:
    let
      system = "x86_64-linux";
      user = "tommy";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations =
        (
          import ./hosts
            {
              inherit (nixpkgs) lib;
              inherit inputs user system home-manager neovim-nightly-overlay;
            }
        );

      # moebius = lib.nixosSystem
      #   {
      #     inherit system;
      #     modules = [
      #       ./hosts/moebius
      #       home-manager.nixosModules.home-manager
      #       {
      #         # extraSpecialArgs = {
      #         #   inherit neovim-nightly-overlay;
      #         # };
      #         home-manager.useGlobalPkgs = true;
      #         home-manager.useUserPackages = true;
      #         home-manager.users.tommy = import ./home.nix;
      #       }
      #     ];
      #   };
      #audron = lib.nixosSystem {
      #  inherit system;
      #  modules = [ 
      #    ./hosts/configuration.nix
      #    home-manager.nixosModules.home-manager
      #    {
      #      home-manager.useGlobalPkgs = true;
      #      home-manager.useUserPackages = true;
      #      home-manager.users.tommy = import ./home.nix;
      #    }
      #  ];
      #};
    };
}
