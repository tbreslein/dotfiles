{ config, pkgs, user, ... }:

{
  security = {
    doas = {
      enable = true;
      wheelNeedsPassword = true;
    };
    sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
  };

  users.users.tommy = {
    name = user;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" ];
    shell = pkgs.fish;
  };
}
