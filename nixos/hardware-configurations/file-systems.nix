{ config, lib, pkgs, ... }:

{
  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/home";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

  # It seems like nixos automatically picks up the disk when it is labelled "swap"
  # swapDevices = [
  #   { device = "/dev/disk/by-label/swap";
  #     encrypted.enable = false; # TODO: This is BAD! I should really move to full disk encryption
  #   }
  # ];
}
