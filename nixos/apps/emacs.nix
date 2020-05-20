# My emacs setup (together with ../.emacs.d/)

{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    autoconf gnumake # for AUCTeX through emacs' el-get
    aspell
    aspellDicts.da
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
  ];

  environment.variables.ASPELL_CONF = "dict-dir /run/current-system/sw/lib/aspell";
}
