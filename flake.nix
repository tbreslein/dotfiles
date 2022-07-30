{
  description = "nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
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
          modules = [ ./moebius-configuration.nix ];
        };
        audron = lib.nixosSystem {
          inherit system;
          modules = [ ./audron-configuration.nix ];
        };
      };
    };
}
