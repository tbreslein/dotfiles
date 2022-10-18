{ config, pkgs, user, ... }:

{
  security = {
    doas = {
      enable = true;
      wheelNeedsPassword = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          keepEnv = true;
        }
      ];
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
