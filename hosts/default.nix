{ lib, inputs, system, user, homeDir, overlays, colors, ... }:

let
  mkHost = hostname: {
    inherit system;
    specialArgs = { inherit inputs user homeDir; };
    modules = [
      { _module.args = inputs; }
      { nixpkgs.overlays = overlays; }
      ./${hostname}
      ./configuration.nix
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user homeDir inputs colors; };
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ] ++ [ (import ./${hostname}/home.nix) ];
        };
      }
    ];
  };
in
{
  moebius = lib.nixosSystem (mkHost "moebius");
  audron = lib.nixosSystem (mkHost "audron");
}
