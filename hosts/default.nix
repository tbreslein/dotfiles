{ lib, inputs, system, home-manager, user, neovim-nightly-overlay, ... }:

{
  moebius = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user inputs neovim-nightly-overlay; };
    modules = [
      ./moebius
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user neovim-nightly-overlay; };
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ] ++ [ (import ./moebius/home.nix) ];
        };
      }
    ];
  };
}
