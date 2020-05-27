{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bind
    discount # markdown
    file
    file
    git
    htop
    screen
    unzip
    wget
    whois
    whois
  ];
}
