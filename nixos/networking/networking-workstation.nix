# Network config for my workstation
{ config, lib, pkgs, ... }:

let secrets = import ../secrets.nix;
in
rec {
  imports = [
    ./aau-vpn.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      networkmanager
      networkmanagerapplet # provides nm-connection-editor (GUI)
    ];
  };

  networking.hostName = "kidmose-desktop"; # Define your hostname.
  # create a self-resolving hostname entry in /etc/hosts
  networking.extraHosts = "127.0.1.1 kidmose-desktop";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # and:
  # wpa_passphrase ESSID PSK >> /etc/wpa_supplicant.conf

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp5s0.useDHCP = true;

  networking.networkmanager.enable = true;
  
}
