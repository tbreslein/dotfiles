{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];
  nix.settings.cores = 12;

  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    loader.timeout = 5;
  };

  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };
  };

  networking.hostName = "moebius";

  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';
  };
}
