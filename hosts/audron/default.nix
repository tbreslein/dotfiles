{ config, lib, pkgs, homeDir, ... }:

let
  home-eth-interface = "enp0s13f0u1";
  work-eth-interface = "enp0s13f0u1u4";
  wifi-interface = "wlp170s0";
in
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
  nix.settings.cores = 4;

  #sources: https://github.com/NixOS/nixos-hardware/blob/master/framework/default.nix

  boot = {
    extraModprobeConfig = "options snd-hda-intel model=dell-headset=multi";
    kernelParams = [ "mem_sleep_default=deep" "nvme.noacpi=1" ]; # both for power consumption
    loader.timeout = 1;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  environment = {
    systemPackages = with pkgs; [
      (writeShellScriptBin "backup-to-styx" ''
        rsync -a --info=progress2 ${homeDir}/work ganymedroot:/archive/admin/audron/$(date +%F)/
      '')

      # needed for eduroam:
      openssl
      cacert
    ];
  };

  hardware = {
    # Mis-detected by nixos-generate-config
    acpilight.enable = lib.mkDefault true;
    bluetooth.enable = true;
    opengl = {
      extraPackages = with pkgs; [
        mesa.drivers
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
      ];
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };

  programs = {
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.slock}/bin/slock";
    };
  };

  services = {
    avahi.interfaces = [ home-eth-interface wifi-interface ];
    blueman.enable = true;
    fprintd.enable = true; #fingerprint support
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
        START_CHARGE_THRESH_BAT0 = 90;
        STOP_CHARGE_THRESH_BAT0 = 97;
        RUNTIME_PM_ON_BAT = "auto";
      };
    };

    # Fix headphone noise when on powersave
    # https://community.frame.work/t/headphone-jack-intermittent-noise/5246/55
    udev.extraRules = ''
      SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0xa0e0", ATTR{power/control}="on"
    '';

    xserver = {
      libinput.enable = true; #touchpad
      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      '';
    };

    printing.clientConf = ''
      ServerName 172.19.66.2
    '';
  };

  networking = {
    hostName = "audron";
    firewall = {
      enable = true;
      interfaces."${work-eth-interface}".allowedTCPPorts = [ 22 ];
    };
    wireless.networks = {
      eduroam = {
        auth = ''
          proto=RSN
          key_mgmt=WPA-EAP
          eap=PEAP
          identity="supas276-cau@uni-kiel.de"
          #password=hash:hashed-password
          domain_suffix_match="radius.rz.uni-kiel.de"
          anonymous_identity="eduroam2022@uni-kiel.de"
          phase1="peaplabel=0"
          phase2="auth=MSCHAPV2"
          #ca_cert="/etc/ssl/certs/ca-bundle.crt"
          ca_cert="/etc/ssl/certs/ca-bundle.crt"
        '';
      };
    };
    extraHosts = ''
      134.245.12.33 smtp.mail.uni-kiel.de
      134.245.10.7 ts1.rz.uni-kiel.de # RZ time service
      134.245.1.36 ts2.rz.uni-kiel.de # RZ time service
      134.245.2.194 ftp.rz.uni-kiel.de
      134.245.64.12 domas.physik.uni-kiel.de domas
      134.245.64.126 router.physik.uni-kiel.de router64
      172.19.64.92 printsrv.theo-physik.uni-kiel.de printsrv #printserver theo. physik
      # 134.245.64.12 print.physik.uni-kiel.de
      134.245.70.20 cups.physik.uni-kiel.de ieapprint # ieap printserver
      134.245.13.88 campuskopierer.uni-kiel.de campuskopierer # printserver ricooh kopierer
      195.135.220.3 www.suse.com suseupdate


      # illenseer notebook
      134.245.66.135 sedna.astrophysik.uni-kiel.de sedna

      # old number cruncher wolf; formlery ganymed now install plattform for saturn & portia
      134.245.66.8 naiad.astrophysik.uni-kiel.de naiad

      # duschl notebook (january 2020)
      134.245.66.115 d12.astrophysik.uni-kiel.de d12

      # IDL server
      134.245.66.71 dwarf16.astrophysik.uni-kiel.de dwarf16

      # duschl ms surface pro4
      134.245.66.134 d11.astrophysik.uni-kiel.de d11

      # nextcloud
      134.245.66.82 dwarf30.astrophysik.uni-kiel.de dwarf30

      # duschl dell tablet
      134.245.66.54 d6.astrophysik.uni-kiel.de d6

      # R.133
      134.245.66.86 dwarf32.astrophysik.uni-kiel.de dwarf32

      # R.147
      134.245.66.79 dwarf20.astrophysik.uni-kiel.de dwarf20

      # duschl notebook fujitsu tablet pc
      134.245.66.30 d5.astrophysik.uni-kiel.de d5

      # R.136
      134.245.66.70 io.astrophysik.uni-kiel.de io

      # old backups ++ nfs
      134.245.66.67 uranus.astrophysik.uni-kiel.de uranus

      # duschl notebook studioline
      134.245.66.15 d4.astrophysik.uni-kiel.de d4

      # raspberry pi for the telescope setup
      134.245.66.75 astropi.astrophysik.uni-kiel.de astropi

      # astro print server
      172.19.66.2 lpastro.astrophysik.uni-kiel.de lpastro

      # duschl notebook Latitude D830
      134.245.66.55 astroIV.astrophysik.uni-kiel.de astroIV

      # slurm node wolf (studis)
      134.245.66.10 kronos.astrophysik.uni-kiel.de kronos

      # nfs host
      134.245.66.9 rhea.astrophysik.uni-kiel.de rhea

      # R.135
      134.245.66.7 juliet.astrophysik.uni-kiel.de juliet

      # astro lab notebook
      134.245.66.29 cicero.astrophysik.uni-kiel.de cicero

      # slurm node wolf (studis)
      134.245.66.2 mars.astrophysik.uni-kiel.de mars

      # nfs host
      134.245.66.102 hera.astrophysik.uni-kiel.de hera

      # klee notebook
      134.245.66.101 christiansennb.astrophysik.uni-kiel.de christiansennb

      # raspberry pi for the seminar room
      134.245.66.91 zoompi.astrophysik.uni-kiel.de zoompi

      # slurm node Duschl
      134.245.66.13 atlas.astrophysik.uni-kiel.de atlas

      # klee notebook
      134.245.66.97 klee.astrophysik.uni-kiel.de klee

      # USB-Ethernet adapter ICY-Box (ITAP)
      134.245.66.121 icybox1.astrophysik.uni-kiel.de icybox1

      # slurm node Duschl
      134.245.66.94 hydra.astrophysik.uni-kiel.de hydra

      # student notebook
      134.245.66.26 kirke.astrophysik.uni-kiel.de kirke

      # USB-Ethernet adapter ICY-Box (Deschner)
      134.245.66.122 icybox2.astrophysik.uni-kiel.de icybox2

      # slurm node wolf
      134.245.66.99 prometheus.astrophysik.uni-kiel.de prometheus

      # old lab notebook?
      134.245.66.96 niobe.astrophysik.uni-kiel.de niobe

      # farblaser oarte, HP CP 4005
      134.245.66.69 oarte.astrophysik.uni-kiel.de oarte

      # slurm node Wolf ++ dhcpd fallover
      134.245.66.6 oberon.astrophysik.uni-kiel.de oberon

      # wolf netbook2
      134.245.66.53 netwolf2.astrophysik.uni-kiel.de netwolf2

      # R.136
      134.245.66.89 galileo.astrophysik.uni-kiel.de galileo

      # farblaser arte
      134.245.66.61 arte.astrophysik.uni-kiel.de arte

      # slurm node wolf (studis)
      134.245.66.87 sirius.astrophysik.uni-kiel.de sirius

      # wolf notebook lenovo (new Dec. 2019)
      134.245.66.28 wolf1.astrophysik.uni-kiel.de wolf1

      # npuck - HP SW Laser M507 DN
      134.245.66.62 puck.astrophysik.uni-kiel.de puck

      # slurm node wolf
      134.245.66.80 groot.astrophysik.uni-kiel.de groot

      # R.338
      134.245.66.16 dwarf15.astrophysik.uni-kiel.de dwarf15

      # wolf notebook thinkpad; astroseminar
      134.245.66.24 wolf.astrophysik.uni-kiel.de wolf

      # R.338
      134.245.66.14 dwarf14.astrophysik.uni-kiel.de dwarf14

      # kretzschmar notebook
      134.245.66.18 kretzschmarnb.astrophysik.uni-kiel.de kretzschmarnb

      # slurm node wolf (studis)
      134.245.66.65 venus.astrophysik.uni-kiel.de venus

      # R.135a
      134.245.66.42 dwarf03.astrophysik.uni-kiel.de dwarf03

      # private notebook, bellomo
      134.245.66.21 marconotebook.astrophysik.uni-kiel.de marconotebook

      # wolf webserver
      134.245.66.93 portia.astrophysik.uni-kiel.de portia

      # webserver / gateway
      134.245.66.1 saturn.astrophysik.uni-kiel.de saturn

      # lubenow notebook
      134.245.66.17 lubenownb2.astrophysik.uni-kiel.de lubenownb2

      # gitlab-runner / misc. services
      134.245.66.5 neptun.astrophysik.uni-kiel.de neptun

      # lubenow notebook
      134.245.66.12 lubenownb.astrophysik.uni-kiel.de lubenownb

      # secretary office
      134.245.66.85 xiang2.astrophysik.uni-kiel.de xiang2

      # slurm control ++ ansible control
      134.245.66.4 ganymed.astrophysik.uni-kiel.de ganymed

      # Lenovo Thinkpad W520; formerly notebook-2 wolf
      134.245.66.23 hati.astrophysik.uni-kiel.de hati

      # R.
      134.245.66.118 procyon.astrophysik.uni-kiel.de procyon

      # fileserver for /astro, and /star ++ main dhcpd
      134.245.66.3 styx.astrophysik.uni-kiel.de styx

      # Lenovo Thinkpad T560; formerly Wolf notebook; runs ubuntu
      134.245.66.19 skoll.astrophysik.uni-kiel.de skoll

      # 
      172.19.66.12 kronos-ipmi.astrophysik.uni-kiel.de kronos-ipmi

      # samsung multiport adapter
      134.245.66.141 samsung-dock-02.astrophysik.uni-kiel.de samsung-dock-02

      # R.340
      134.245.66.66 mifo-hp3.astrophysik.uni-kiel.de mifo-hp3

      # 
      172.19.66.10 oberon-ipmi.astrophysik.uni-kiel.de oberon-ipmi

      # R.327
      134.245.66.60 mifo-hp2.astrophysik.uni-kiel.de mifo-hp2

      # R.159
      134.245.66.76 dwarf17.astrophysik.uni-kiel.de dwarf17

      # 
      172.19.66.15 atlas-ipmi.astrophysik.uni-kiel.de atlas-ipmi

      # R.340
      134.245.66.59 mifo-hp1.astrophysik.uni-kiel.de mifo-hp1

      # R.338
      134.245.66.77 dwarf18.astrophysik.uni-kiel.de dwarf18

      # 
      172.19.66.16 rhea-ipmi.astrophysik.uni-kiel.de rhea-ipmi

      # R.141
      134.245.66.133 dwarf46.astrophysik.uni-kiel.de dwarf46

      # R.338
      134.245.66.78 dwarf19.astrophysik.uni-kiel.de dwarf19

      # 
      172.19.66.17 hydra-ipmi.astrophysik.uni-kiel.de hydra-ipmi

      # R.340
      134.245.66.132 dwarf45.astrophysik.uni-kiel.de dwarf45

      # R.331
      134.245.66.31 dwarf21.astrophysik.uni-kiel.de dwarf21

      # 
      172.19.66.11 prometheus-ipmi.astrophysik.uni-kiel.de prometheus-ipmi

      # R.144
      134.245.66.131 dwarf44.astrophysik.uni-kiel.de dwarf44

      # R.137
      134.245.66.32 dwarf22.astrophysik.uni-kiel.de dwarf22

      # 
      172.19.66.18 hera-ipmi.astrophysik.uni-kiel.de hera-ipmi

      # R.145
      134.245.66.104 dwarf43.astrophysik.uni-kiel.de dwarf43

      # R.142
      134.245.66.33 dwarf23.astrophysik.uni-kiel.de dwarf23

      # 
      172.19.66.19 ganymed-ipmi.astrophysik.uni-kiel.de ganymed-ipmi

      # R.331
      134.245.66.48 dwarf42.astrophysik.uni-kiel.de dwarf42

      # R.337
      134.245.66.34 dwarf24.astrophysik.uni-kiel.de dwarf24

      # cisco switchI
      172.19.66.13 switchI.astrophysik.uni-kiel.de switchI

      # R.135
      134.245.66.47 dwarf41.astrophysik.uni-kiel.de dwarf41

      # R.337
      134.245.66.35 dwarf25.astrophysik.uni-kiel.de dwarf25

      # cisco switchII
      172.19.66.14 switchII.astrophysik.uni-kiel.de switchII

      # samsung multiport adapter
      134.245.66.140 samsung-dock-01.astrophysik.uni-kiel.de samsung-dock-01

      # R.139
      134.245.66.43 dwarf40.astrophysik.uni-kiel.de dwarf40

      # is this a printer?
      134.245.66.63 theas.astrophysik.uni-kiel.de theas

      # breslein notebook dock
      134.245.66.137 audron.astrophysik.uni-kiel.de audron

      # R.133
      134.245.66.98 dwarf39.astrophysik.uni-kiel.de dwarf39

      # is this a printer?
      134.245.66.64 hiob.astrophysik.uni-kiel.de hiob

      # lenovo thinkcentre for the seminar room
      134.245.66.22 astrosem.astrophysik.uni-kiel.de astrosem

      # R.327
      134.245.66.58 dwarf38.astrophysik.uni-kiel.de dwarf38

      # secretary office
      134.245.66.84 ariel.astrophysik.uni-kiel.de ariel

      # guest notebook reissl
      134.245.66.124 reissl.astrophysik.uni-kiel.de reissl

      # R.145
      134.245.66.57 dwarf37.astrophysik.uni-kiel.de dwarf37

      # secretary office
      134.245.66.88 duschl.astrophysik.uni-kiel.de duschl

      # guest notebook schindler
      134.245.66.125 schindler.astrophysik.uni-kiel.de schindler

      # R.141
      134.245.66.46 dwarf36.astrophysik.uni-kiel.de dwarf36

      # notebook xps m1210
      134.245.66.20 iphigenie.astrophysik.uni-kiel.de iphigenie

      # R.140
      134.245.66.45 dwarf35.astrophysik.uni-kiel.de dwarf35

      # wolf notebook
      134.245.66.81 fenrir.astrophysik.uni-kiel.de fenrir

      # R.142
      134.245.66.92 dwarf34.astrophysik.uni-kiel.de dwarf34

      # cups idl DNS
      134.245.66.100 astro.astrophysik.uni-kiel.de astro

      # notebook koeppen
      134.245.66.51 koeppen-adapt.astrophysik.uni-kiel.de koeppen-adapt

      # R.144
      134.245.66.90 dwarf33.astrophysik.uni-kiel.de dwarf33

      # old comment: NB Beamer Toshiba DNS
      134.245.66.126 router.astrophysik.uni-kiel.de router

      # zielinski notebook
      134.245.66.95 nikoziel.astrophysik.uni-kiel.de nikoziel

      # R.136
      134.245.66.83 dwarf31.astrophysik.uni-kiel.de dwarf31

      # Sun Theo. Physik
      172.19.71.9 usv.astrophysik.uni-kiel.de usv

      # lirawi notebook
      134.245.66.27 lirawi.astrophysik.uni-kiel.de lirawi

      # R.340
      134.245.66.39 dwarf29.astrophysik.uni-kiel.de dwarf29

      # Sun Server Theo. Physik
      134.245.67.1 solid.astrophysik.uni-kiel.de solid

      # boesch notebook
      134.245.66.25 lboesch.astrophysik.uni-kiel.de lboesch

      # R.337
      134.245.66.37 dwarf27.astrophysik.uni-kiel.de dwarf27

      # Sun Theo. Physik
      134.245.67.1 orff.astrophysik.uni-kiel.de orff

      # lietzownb
      134.245.66.41 lietzownb.astrophysik.uni-kiel.de lietzownb

      # R.337
      134.245.66.36 dwarf26.astrophysik.uni-kiel.de dwarf26

      # Inst. Server
      134.245.67.199 enterprise.astrophysik.uni-kiel.de enterprise

      # stuber notebook
      134.245.66.40 thinkpad_e15.astrophysik.uni-kiel.de thinkpad_e15

      # charon
      134.245.66.11 charon.astrophysik.uni-kiel.de charon
    '';
  };
}
