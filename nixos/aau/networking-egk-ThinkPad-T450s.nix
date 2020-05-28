# Network config for my AAU laptop
{ config, lib, pkgs, ... }:

let secrets = import ../secrets.nix;
in
rec {
  environment = {
    systemPackages = with pkgs; [
      networkmanager
      networkmanagerapplet # provides nm-connection-editor (GUI)
      # openconnect as a cisco vpn client
      openconnect
      networkmanager-openconnect
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

  environment.etc."NetworkManager/system-connections/aau-vpn.nmconnection" = {
    text = ''
      [connection]
      id=aau-vpn
      uuid=cf80825f-4d0f-4b4e-902e-86d0851f0c4f
      type=vpn
      autoconnect=false
      permissions=

      [vpn]
      authtype=password
      autoconnect-flags=0
      cacert=/etc/nixos/aau/iesca.crt
      certsigs-flags=0
      cookie-flags=2
      enable_csd_trojan=no
      gateway=ssl-vpn1.aau.dk
      gateway-flags=2
      gwcert-flags=2
      lasthost-flags=0
      pem_passphrase_fsid=no
      prevent_invalid_cert=no
      protocol=anyconnect
      stoken_source=totp
      xmlconfig-flags=0
      service-type=org.freedesktop.NetworkManager.openconnect

      [ipv4]
      dns-search=
      method=auto

      [ipv6]
      addr-gen-mode=stable-privacy
      dns-search=
      ip6-privacy=0
      method=auto

      [proxy]
    '';
    mode = "0400";
  };
}
