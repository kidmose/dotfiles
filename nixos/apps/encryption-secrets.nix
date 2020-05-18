{ config, pkgs, ... }:
{
  # For opening eCryptfs encrypted /home/*
  security.pam.enableEcryptfs = true;

  # Packages to install
  environment.systemPackages = with pkgs; [
    gnupg
    keepassx2
    gnome3.gnome-keyring
    gnome3.seahorse # gui for gnome-keyring (and pgp and ssh key passphrases)
  ];

  services.gnome3.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true; # unlock on login from lightdm
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true; # also serve as `ssh-agent`
    pinentryFlavor = "gnome3";
  };
}
