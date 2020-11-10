{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    baobab
    drawio
    slack
  ];
}
