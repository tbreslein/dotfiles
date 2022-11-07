{ config, pkgs, ... }:

{
  programs = {
    alacritty.settings.font.size = 10;

    autorandr.profiles = {
      "dual" = {
        fingerprint = {
          DisplayPort-0 = "00ffffffffffff0061a9443400000000101e0104b55021783b64f5ad5049a322135054adcf00714f81c0814081809500a9c0b300d1c0226870a0d0a02950302035001d4e3100001a20fd70a0d0a03c50302035001d4e3100001e000000fd003090a0a03c010a202020202020000000fc004d69204d6f6e69746f720a202002ac020320f44c010203040590111213141f3f2309070783010000e6060701605d29023a801871382d40582c96001d4e3100001e20ac00a0a0382d40302035001d4e3100001ef0d270a0d0a03c50302035001d4e3100001ea348b86861a03250304035001d4e3100001ef57c70a0d0a02950302035001d4e3100001e00000000006b7012790000030014bf2f01046f0d9f002f001f009f053b000280040007000a0881000804000402100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e190";
          DisplayPort-2 = "00ffffffffffff001e6d3e5b010101010b1a0104a53c2278fa7b45a4554aa2270b5054210800714081c08100818095009040a9c0b300023a801871382d40582c450058542100001e000000fd00384b1e530f000a202020202020000000fc00424b373530590a202020202020000000ff000a202020202020202020202020016c02031cf149900403011012101f13230907078301000065030c001000023a801871382d40582c4500fe221100001e011d007251d01e206e285500fe221100001e8c0ad08a20e02d10103e9600fe2211000018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e2";
        };
        config = {
          DisplayPort-0 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "3440x1440";
            rate = "120.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
          DisplayPort-2 = {
            enable = true;
            crtc = 1;
            primary = false;
            position = "3440x180";
            mode = "1920x1080";
            rate = "60.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
        };
        hooks.postswitch = "feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png $HOME/MEGA/Wallpaper/cyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg";
      };
      "tv" = {
        fingerprint = {
          DisplayPort-0 = "00ffffffffffff0061a9443400000000101e0104b55021783b64f5ad5049a322135054adcf00714f81c0814081809500a9c0b300d1c0226870a0d0a02950302035001d4e3100001a20fd70a0d0a03c50302035001d4e3100001e000000fd003090a0a03c010a202020202020000000fc004d69204d6f6e69746f720a202002ac020320f44c010203040590111213141f3f2309070783010000e6060701605d29023a801871382d40582c96001d4e3100001e20ac00a0a0382d40302035001d4e3100001ef0d270a0d0a03c50302035001d4e3100001ea348b86861a03250304035001d4e3100001ef57c70a0d0a02950302035001d4e3100001e00000000006b7012790000030014bf2f01046f0d9f002f001f009f053b000280040007000a0881000804000402100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e190";
          HDMI-A-0 = "00ffffffffffff001e6d3876010101010113010380462778ead9b0a357499c2511494ba1080031404540614081809040d1c0010101011a3680a070381f4030203500e8263200001a1b2150a051001e3048883500bc862100001c000000fd00394b1f5412000a202020202020000000fc0033374c47373030300a2020202001ca020325f15081020306071516121304140520221f10230957078301000067030c004000b82d011d008051d01c2040803500bc882100001e8c0ad08a20e02d10103e9600138e21000018023a801871382d40582c450006442100001e011d8018711c1620582c2500c48e2100009e4e1f008051001e3040803700bc8821000018ae";
          DisplayPort-2 = "00ffffffffffff001e6d3e5b010101010b1a0104a53c2278fa7b45a4554aa2270b5054210800714081c08100818095009040a9c0b300023a801871382d40582c450058542100001e000000fd00384b1e530f000a202020202020000000fc00424b373530590a202020202020000000ff000a202020202020202020202020016c02031cf149900403011012101f13230907078301000065030c001000023a801871382d40582c4500fe221100001e011d007251d01e206e285500fe221100001e8c0ad08a20e02d10103e9600fe2211000018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e2";
        };
        config = {
          DisplayPort-0 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "1920x0";
            mode = "3440x1440";
            rate = "120.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
          HDMI-A-0 = {
            enable = true;
            crtc = 2;
            primary = false;
            position = "0x180";
            mode = "1920x1080";
            rate = "60.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
          DisplayPort-2 = {
            enable = true;
            crtc = 1;
            primary = false;
            position = "5360x180";
            mode = "1920x1080";
            rate = "60.00";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
        };
        hooks.postswitch = "feh --bg-fill $HOME/MEGA/Wallpaper/dp-2_3.png $HOME/MEGA/Wallpaper/cyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg $HOME/MEGA/Wallpaper/cyberpunk-the-last-nigh-video-games-pixel-art-wallpaper.jpg";
      };
    };
  };

  home.file = {
    "zellij_moebius_layout" = {
      target = ".config/zellij/layouts/moebius.kdl";
      executable = false;
      text = ''
        layout {
          default_tab_template {
            pane size=1 borderless=true {
              plugin location="zellij:tab-bar"
            }
            children
              pane size=2 borderless=true {
                plugin location="zellij:status-bar"
              }
          }
          tab name="dev1" cwd="/home/tommy/coding/" split_direction="vertical" {
            pane name="nvim" size="70%" focus=true
              pane name="shell" size="30%"
          }
          tab name="dev2" split_direction="vertical" cwd="/home/tommy/coding/" {
            pane
              pane
          }
          tab name="home" split_direction="vertical" cwd="/home/tommy/" {
            pane
              pane
              pane
          }
          tab name="dots1" cwd="/home/tommy/.dotfiles/" {
            pane name="nvim" size="70%"
              pane size="30%"
          }
        }
      '';
    };
  };

  xsession = {
    initExtra = ''
      megasync &
      dwmblocks &
      autorandr -c
    '';
  };
}
