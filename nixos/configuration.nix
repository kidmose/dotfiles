{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./aau/networking-egk-ThinkPad-T450s.nix
      ./aau/aau.nix
      ./apps/emacs.nix
      ./apps/latex.nix
      ./apps/encryption-secrets.nix
      ./apps/x11.nix
      ./apps/xfce.nix
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
    evince
    discord
    # ecryptfs
    # ecryptfs-helper
    emacs
    evince
    firefox
    git
    htop
    meld
    nextcloud-client
    screen
    skype
    teams
    thunderbird
    wget
    alacritty
  ];

  # docker
  virtualisation.docker.enable = true;
  
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "dk";
    xkbOptions = "eurosign:e";
    # Enable touchpad support.
    libinput.enable = true;
    # Enable the KDE Desktop Environment.
    # displayManager.sddm.enable = true;
    # desktopManager.plasma5.enable = true;
  };

  # Users, groups and rights
  users.users.root.initialHashedPassword = "";
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.egk = {
    isNormalUser = true;
    extraGroups = [
      "wheel"  # Enable ‘sudo’ for the user.
      "docker"
    ];
  };

  # OS config
  system.stateVersion = "20.03"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
}

