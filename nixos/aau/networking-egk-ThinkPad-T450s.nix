# Network config for my AAU laptop
{ config, lib, pkgs, ... }:

{
  networking.hostName = "egk-ThinkPad-T450s"; # Define your hostname.
  # create a self-resolving hostname entry in /etc/hosts
  networking.extraHosts = "127.0.1.1 egk-ThinkPad-T450s";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
