{ config, pkgs, ... }:
let
  s = import ./secrets.nix;
in
{
  imports = [
    ../../apps/cli.nix
    ../../apps/emacs.nix
    ../../apps/i3.nix
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

  environment.systemPackages = with pkgs; [
  ];
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark; # does *-cli, i.e. tshark, by default

  # docker
  virtualisation.docker.enable = true;

  users.mutableUsers = false;
  users.users.root.hashedPassword = "*";
  users.users.${s.os.user.name} = {
    isNormalUser = true;
    description = s.os.user.description;
    hashedPassword = s.os.user.hashedPassword;
    extraGroups = [
      "wheel"  # Enable ‘sudo’ for the user.
      "vboxsf"
      "networkmanager"
      "docker"
      "wireshark"
    ];
  };
  services.mingetty.autologinUser = s.os.user.name;

  virtualisation.virtualbox.guest.enable = true;

  services.xserver.displayManager.lightdm = {
    autoLogin.enable = true;
    autoLogin.user = "${s.os.user.name}";
  };
}
