{ config, pkgs, ... }:
let
  python = pkgs.python38;
in {
  environment.systemPackages = [
    ( python.buildEnv.override  {
      extraLibs = with pkgs.python38Packages; [
        numpy
        virtualenvwrapper
        ipython
        jupyter
        pandas
      ];
    })
  ];
}
