{ config, lib, pkgs, stdenv, ... }:
{
  services.clipmenu.enable = true; # light clipboard manager

  environment.variables.CM_LAUNCHER = "rofi"; # use rofi in clipmanager

  environment.systemPackages = with pkgs; [
    scrot                     # take screenshots
    xclip                     # clipboard utility
    gnome3.gnome-screenshot
    clipmenu
  ];
}
