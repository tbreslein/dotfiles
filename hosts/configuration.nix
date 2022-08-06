{ config, pkgs, user, homeDir, dwm, useWayland, ... }:

{
  imports = [
    (import ./configuration-modules/users.nix { inherit config pkgs user; })
    (import ./configuration-modules/activationScripts.nix { inherit config homeDir; })
    (import ./configuration-modules/packages.nix { inherit config pkgs homeDir useWayland; })
    (import ./configuration-modules/wm.nix { inherit config pkgs homeDir useWayland; })
  ] ++ [
    ./configuration-modules/boot.nix
    ./configuration-modules/printing-scanning.nix
    ./configuration-modules/sound.nix
    ./configuration-modules/virtualisation.nix
  ];

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
  ];
  time.timeZone = "Europe/Berlin";
  networking.networkmanager.enable = true;

  services = {
    fstrim.enable = true;
    geoclue2.enable = true;
    interception-tools = {
      enable = true;
      plugins = with pkgs; [ interception-tools-plugins.caps2esc ];
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc -m 1 | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };
    xserver = {
      xkbModel = "pc105";
      xkbOptions = "";
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "22.05"; # Did you read the comment?
}
