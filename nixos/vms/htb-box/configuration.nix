{ config, pkgs, ... }:
let
  s = import ./secrets.nix;
in
{
  imports = [
    ../../apps/cli.nix
    ../../apps/python.nix
  ];

  nixpkgs.config.allowUnfree = true;
  # Boot loader
  boot.loader.timeout = 0;

  # Localisation
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dk";
  };
  time.timeZone = "Europe/Copenhagen";

  users.mutableUsers = false;
  users.users.root.hashedPassword = "*";
  users.users.${s.os.user.name} = {
    isNormalUser = true;
    description = s.os.user.description;
    hashedPassword = s.os.user.hashedPassword;
    extraGroups = [
      "wheel"  # Enable ‘sudo’ for the user.
      "networkmanager"
      "docker"
      "wireshark"
    ];
    openssh.authorizedKeys.keys = s.os.user.keys;
  };
  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    forwardX11 = true;
    permitRootLogin = "no";
  };
  
  # docker
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
  ];
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark; # does *-cli, i.e. tshark, by default

}
