{ config, pkgs, user, ... }:

let
  user = "tommy";
  configDir = "/home/tommy/.dotfiles/config";
  dwmConfigFile = "${configDir}/dwm-config.h";
  dwmblocksConfigFile = "${configDir}/dwmblocks-config.h";
in
{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (self: super: {
        dwm = super.dwm.overrideAttrs (oldAttrs: {
          src = fetchGit {
            url = "https://gitlab.com/tbreslein/dwm.git";
            ref = "build";
          };
          postPatch = oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${super.writeText "config.h" (builtins.readFile "${dwmConfigFile}")} config.def.h";
        });
      })

      (self: super: {
        dwmblocks = super.dwmblocks.overrideAttrs (oldAttrs: {
          postPatch = oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${super.writeText "blocks.h" (builtins.readFile "${dwmblocksConfigFile}")} blocks.def.h";
        });
      })
    ];
  };

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        version = 2;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 5;
      };
      timeout = 5;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "moebius"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Berlin";

  services = {
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
      enable = true;
      videoDrivers = [ "amdgpu" ];
      layout = "us";
      displayManager = {
        startx.enable = true;
        defaultSession = "none+dwm";
        lightdm.enable = true;
        autoLogin.enable = true;
        autoLogin.user = "tommy";
      };
      windowManager.dwm.enable = true;
    };
    printing.enable = true;
  };

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware = {
    pulseaudio.enable = true;
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ amdvlk rocm-opencl-icd rocm-opencl-runtime ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };
  };

  users.users.tommy = {
    name = user;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    gcc
    wget
    brave
    git
    htop
    alacritty
    dmenu
    dwmblocks
    rnix-lsp
    nixpkgs-fmt
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "22.05"; # Did you read the comment?

}
