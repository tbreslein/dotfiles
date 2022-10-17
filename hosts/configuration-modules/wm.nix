{ config, pkgs, homeDir, ... }:

{
  nixpkgs = {
    overlays = [
      (self: super: {
        dwm = super.dwm.overrideAttrs (oldattrs: {
          src = fetchGit {
            url = "https://github.com/tbreslein/dwm.git";
            ref = "build";
            rev = "7472a24114cd7fca4e039a464a6266428f963898";
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

  environment.systemPackages = with pkgs; [ dwmblocks ];

  programs.light.enable = true;

  services = {
    dbus.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      displayManager = {
        defaultSession = "none+dwm";
        lightdm.enable = true;
        autoLogin = {
          enable = true;
          user = "tommy";
        };
      };
      windowManager.dwm.enable = true;
    };
  };
}
