# Network config for my AAU laptop
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

  environment.etc."NetworkManager/system-connections/${secrets.home.wifi.ssid}.nmconnection" = {
    text = ''
      [connection]
      id=${secrets.home.wifi.ssid}
      uuid=c8b3c2ff-99a5-4e84-bfa3-f7260908574c
      type=wifi
      interface-name=wlp3s0
      permissions=

      [wifi]
      mac-address-blacklist=
      mode=infrastructure
      ssid=${secrets.home.wifi.ssid}

      [wifi-security]
      auth-alg=open
      key-mgmt=wpa-psk
      psk=${secrets.home.wifi.psk}

      [ipv4]
      dns-search=
      method=auto

      [ipv6]
      addr-gen-mode=stable-privacy
      dns-search=
      method=auto

      [proxy]
    '';
    mode = "0400";
  };

  environment.etc."NetworkManager/system-connections/AAU-1x.nmconnection" = {
    text = ''
      [connection]
      id=AAU-1x
      uuid=e80d940e-bb0b-4823-87db-78cd07c21db4
      type=wifi
      interface-name=wlp3s0
      permissions=
      
      [wifi]
      mac-address-blacklist=
      mode=infrastructure
      ssid=AAU-1x
      
      [wifi-security]
      auth-alg=open
      key-mgmt=wpa-eap
      
      [802-1x]
      ca-cert=/etc/nixos/aau/aau_net_ca.crt
      eap=peap;
      identity=${secrets.aau.email}
      password=${secrets.aau.pass}
      phase2-auth=mschapv2
      
      [ipv4]
      dns-search=
      method=auto
      
      [ipv6]
      addr-gen-mode=stable-privacy
      dns-search=
      method=auto
      
      [proxy]
    '';
    mode = "0400";
  };

  environment.etc."NetworkManager/system-connections/iphone.nmconnection" = {
    text = ''
      [connection]
      id=${secrets.iphone.wifi.ssid}
      uuid=e4f73374-ddea-41dc-9665-688cf4b113d3
      type=wifi
      permissions=

      [wifi]
      mac-address-blacklist=
      mode=infrastructure
      ssid=${secrets.iphone.wifi.ssid}

      [wifi-security]
      key-mgmt=wpa-psk
      psk=${secrets.iphone.wifi.psk}

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
