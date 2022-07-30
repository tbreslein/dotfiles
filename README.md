# NixOS setup

## format with encryption

After booting into the medium, and partitioning the disk, setup looks and mount everything

```bash
cryptsetup --type luks1 luksFormat /path/to/root/device
cryptsetup luksOpen /path/to/root/device cryptroot
mkfs.ext4 -L nixos /dev/mapper/cryptroot
mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /path/to/boot/device /mnt/boot
```

Then generate the configs with `nixos-generate-config`, and then `hardware.nix` should contain something like this:

```nix
{ # cut
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5e7458b3-dcd2-49c6-a330-e2c779e99b66";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/d2cb12f8-67e3-4725-86c3-0b5c7ebee3a6";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/863B-7B32";
      fsType = "vfat";
    };

  swapDevices = [ ];
}
```

## configuration

Get my config, or write a new one.
In the latter case, when dual booting, make sure that OSProber is activated
In `hardware.nix`, add "amdgpu" or

