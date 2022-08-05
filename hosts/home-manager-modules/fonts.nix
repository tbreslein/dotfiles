{ config, lib, pkgs, user, ... }:

{
  home.packages = with pkgs; [
    dejavu_fonts
    inconsolata
    inconsolata-nerdfont
    (nerdfonts.override { fonts = [ "AnonymousPro" "Hack" ]; })
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    noto-fonts-extra
    roboto
    ubuntu_font_family
  ];
  fonts.fontconfig.enable = true;
}
