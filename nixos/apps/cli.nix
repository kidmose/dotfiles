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
    gitAndTools.gitflow
    htop
    # inetutils
    traceroute
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
