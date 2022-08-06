{ config, pkgs, homeDir, useWayland, ... }:

let
  # can't I make this pure by using a relative path?
  # dwmConfigFile = ./config/dwm-config.h;
  # dwmblocksConfigFile = ./dwmblocks-config.h;

  configDir = "${homeDir}/.dotfiles/configs";
  dwmblocksConfigFile = "${configDir}/dwmblocks-config.h";
in
{
  nixpkgs = {
    overlays = [
      (self: super: {
        dwm = super.dwm.overrideAttrs (oldAttrs: {
          src = fetchGit {
            url = "https://github.com/tbreslein/dwm.git";
            ref = "build";
            rev = "d41748b534029ddb240cac8733dc062a9a8aeab8";
          };
        });
      })

      (self: super: {
        dwmblocks = super.dwmblocks.overrideAttrs (oldAttrs: {
          postPatch = oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${super.writeText "blocks.h" (builtins.readFile "${dwmblocksConfigFile}")} blocks.def.h";
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
