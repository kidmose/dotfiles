# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ./file-systems.nix
    ];

  boot.initrd.availableKernelModules = [
    "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod"
  ];
  boot.kernelModules = [
    "kvm-amd"
    "amdgpu"
  ];
  boot.extraModulePackages = [ ];

  nix.maxJobs = lib.mkDefault 12;
  # High-DPI console
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  # AMD GPU
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd  # NixOS Unstable
  ];
}
