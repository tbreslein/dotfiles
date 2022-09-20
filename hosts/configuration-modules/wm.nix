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
    systemPackages =
      if useWayland
      then with pkgs; [
        (river.overrideAttrs (prevAttrs: rec {
          postInstall =
            let
              riverSession = ''
                [Desktop Entry]
                Name=River
                Comment=Dynamic Wayland compositor
                Exec=river
                Type=Application
              '';
            in
            ''
              mkdir -p $out/share/wayland-sessions
              echo "${riverSession}" > $out/share/wayland-sessions/river.desktop
            '';
          passthru.providedSessions = [ "river" ];
        }))
        sway
        wayland
        glib
      ]
      else with pkgs; [ dwmblocks ];
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  services = {
    dbus.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      displayManager = {
        defaultSession = if useWayland then "river" else "none+dwm";
        sddm.enable = true;
        sessionPackages =
          if useWayland
          then [
            (pkgs.river.overrideAttrs
              (prevAttrs: rec {
                postInstall =
                  let
                    riverSession = ''
                      [Desktop Entry]
                      Name=River
                      Comment=Dynamic Wayland compositor
                      Exec=river
                      Type=Application
                    '';
                  in
                  ''
                    mkdir -p $out/share/wayland-sessions
                    echo "${riverSession}" > $out/share/wayland-sessions/river.desktop
                  '';
                passthru.providedSessions = [ "river" ];
              })
            )
          ]
          else [ ];
      };
      windowManager.dwm.enable = !useWayland;
    };
  };
}
