{
  description = "nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        moebius = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./moebius-configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPkgs = true;
              home-manager.users.tommy = import ./home.nix;
            }
          ];
        };
        audron = lib.nixosSystem {
          inherit system;
          modules = [ ./audron-configuration.nix ];
        };
      };
    };
}
