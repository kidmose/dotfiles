# My emacs setup (together with ../.emacs.d/)

{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    autoconf gnumake # for AUCTeX through emacs' el-get
  ];
}
