# Using Network Manager and oppenconnect as client for AAU's Cisco AnyConnect
{ config, lib, pkgs, ... }:

let secrets = import ../secrets.nix;
in
rec {
  environment = {
    systemPackages = with pkgs; [
      networkmanager
      # openconnect as a cisco vpn client
      openconnect
      networkmanager-openconnect
    ];
  };

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

      [vpn-secrets]
      form:main:group_list=SSL
      form:main:username=${secrets.aau.email}
      save_passwords=yes

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
