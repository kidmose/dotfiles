{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true; # for Extension Pack

  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };
}
