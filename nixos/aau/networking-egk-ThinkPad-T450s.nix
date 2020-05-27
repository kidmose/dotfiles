# Network config for my AAU laptop
{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      networkmanager
      networkmanagerapplet # provides nm-connection-editor (GUI)

      # openconnect as a cisco vpn client
      openconnect
      networkmanager-openconnect

      # vpnc as a cisco vpn client
      vpnc
      networkmanager-vpnc
    ];
  };

  networking.hostName = "egk-ThinkPad-T450s"; # Define your hostname.
  # create a self-resolving hostname entry in /etc/hosts
  networking.extraHosts = "127.0.1.1 egk-ThinkPad-T450s";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # and:
  # wpa_passphrase ESSID PSK >> /etc/wpa_supplicant.conf

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  networking.networkmanager.enable = true;
}
