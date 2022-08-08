{ config, pkgs, homeDir, useWayland, ... }:

{
  nixpkgs = {
    overlays = [
      (self: super: {
        dwm = super.dwm.overrideAttrs (oldattrs: {
          src = fetchGit {
            url = "https://github.com/tbreslein/dwm.git";
            ref = "build";
            rev = "ba4a8896090bde236fc679a3e041179ac520e99d";
          };
        });
      })

      (self: super: {
        dwmblocks = super.dwmblocks.overrideAttrs (oldattrs: {
          src = fetchGit {
            url = "https://github.com/tbreslein/dwmblocks.git";
            ref = "build";
            rev = "37bb6fc7c20c8c2746a0c708d96c8a805cb73637";
          };
        });
      })
    ];
  };

  environment = {
    systemPackages = if useWayland then [ ] else with pkgs; [ dwmblocks ];
  };

  services.xserver = {
    enable = true;
    layout = "us";
    displayManager = {
      defaultSession = if useWayland then "none+river" else "none+dwm";
      sddm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "tommy";
    };
    windowManager.dwm.enable = !useWayland;
  };
}
