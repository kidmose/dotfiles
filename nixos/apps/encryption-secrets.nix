{ config, pkgs, ... }:
{
  # For opening eCryptfs encrypted /home/*
  security.pam.enableEcryptfs = true;

  # Packages to install
  environment.systemPackages = with pkgs; [
    gnupg
    keepassx2
    kwalletcli # for pinetry-kwallet to be used by gpg-agent
  ];

  # Use kwallet to store sshkey and gpg passphrase (for instance for git)
  security.pam.services.sddm.enableKwallet = true; # unlock on login
  # It might be necessary to manually create a wallet with the default
  # name (kdewallet) using a blowfish password, as the default of
  # using a gpg password seems to break nextcloud integration.
  #
  # SSH
  # start the agent, but identity needs to be added manually for each session?
  programs.ssh = {
    startAgent = true;
    askPassword = "${pkgs.ksshaskpass}/bin/ksshaskpass";
  };
  # GPG:
  programs.gnupg.agent.enable = true;
  # TODO: Assert that ~/.gnupg/gpg-agent.conf holds: "pinentry-program
  # /run/current-system/sw/bin/pinentry-kwallet"

  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

}
