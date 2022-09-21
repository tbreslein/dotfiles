{ config, pkgs, homeDir, useWayland, ... }:

let
  # bash script to let dbus know about important env variables and
  # propogate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  #dbus-sway-environment = pkgs.writeTextFile {
  #  name = "dbus-sway-environment";
  #  destination = "/bin/dbus-sway-environment";
  #  executable = true;
  #  text = ''
  #    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  #    systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  #    systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  #  '';
  #};

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  #configure-gtk = pkgs.writeTextFile {
  #  name = "configure-gtk";
  #  destination = "/bin/configure-gtk";
  #  executable = true;
  #  text =
  #    let
  #      schema = pkgs.gsettings-desktop-schemas;
  #      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
  #    in
  #    ''
  #      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
  #      gnome_schema=org.gnome.desktop.interface
  #      gsettings set $gnome_schema gtk-theme Adwaita-dark
  #    '';
  #};

in
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
        glib
      ]
      else with pkgs; [ dwmblocks ];
  };

  programs = {
    #light.enable = true;
    sway.enable = true;
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
