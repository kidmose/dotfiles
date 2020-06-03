{ config, pkgs, ... }:
{
  imports =
    [
      ./aau/aau.nix
      ./aau/networking-egk-ThinkPad-T450s.nix
      ./apps/cli.nix
      ./apps/emacs.nix
      ./apps/encryption-secrets.nix
      ./apps/i3.nix
      ./apps/latex.nix
      ./apps/nextcloud-client.nix
      ./apps/python.nix
      ./apps/sound.nix
      ./apps/virtualbox.nix
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Localisation
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dk";
  };
  time.timeZone = "Europe/Copenhagen";

  # Packages to install
  environment.systemPackages = with pkgs; [
    alacritty
    discord
    emacs
    evince
    firefox
    gnome3.eog
    gnome3.gnome-screenshot
    libreoffice
    meld
    pinta
    skype
    teams
    thunderbird
    vlc
  ];

  # docker
  virtualisation.docker.enable = true;
  
  # Users, groups and rights
  users.users.root.initialHashedPassword = "!"; # Don't leave it blank (IIRC leaving it blank will cause passwd prompt during install)
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.egk = {
    isNormalUser = true;
    extraGroups = [
      "wheel"  # Enable ‘sudo’ for the user.
      "docker"
      "vboxusers"
      "networkmanager"
    ];
  };

  # OS config
  system.stateVersion = "20.03"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
}
