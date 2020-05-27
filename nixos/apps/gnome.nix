{ config, lib, pkgs, stdenv, ... }:
{

  imports = [
    ./x11.nix
  ];

  # services.blueman.enable = true;

  environment = {
    systemPackages = with pkgs; [
    ];
  };

  services.xserver = {
    desktopManager.gnome3.enable = true;
    displayManager = {
      lightdm.enable = true; # manages log-in
      defaultSession = "gnome";
    };

  };
}
