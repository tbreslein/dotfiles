{ lib, inputs, system, home-manager, user, overlays, ... }:

{
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
}
