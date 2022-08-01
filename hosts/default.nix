{ lib, inputs, system, home-manager, user, overlays, ... }:

let
  # mkHost = hostName: inputs: system: home-manager: user: overlays: {
  mkHost = hostName: {
    inherit system;
    specialArgs = { inherit user inputs; };
    modules = [
      "./${hostname}"
      ./configuration.nix
      { nixpkgs.overlays = overlays; }
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user inputs; };
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ] ++ [ (import "./${hostname}/home.nix") ];
        };
      }
    ];
  };
in
{
  # TEST THIS!
  # moebius = lib.nixosSystem mkHost {
  #   hostName = "moebius";
  # };
  # audron = lib.nixosSystem mkHost {
  #   hostName = "audron";
  # };

  moebius = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user inputs; };
    modules = [
      ./moebius
      ./configuration.nix
      { nixpkgs.overlays = overlays; }
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user inputs; };
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ] ++ [ (import ./moebius/home.nix) ];
        };
      }
    ];
  };

  audron = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user inputs; };
    modules = [
      ./audron
      ./configuration.nix
      { nixpkgs.overlays = overlays; }
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user inputs; };
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ] ++ [ (import ./audron/home.nix) ];
        };
      }
    ];
  };
}
