{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bash-completion
    bc
    bind
    curl
    discount # markdown
    file
    git
    htop
    inetutils
    jq
    lsof
    p7zip
    screen
    tmux
    unzip
    vagrant
    wget
    whois
  ];
}
