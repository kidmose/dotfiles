{ config, pkgs, ... }:
let
  python = pkgs.python38;
in {
  # Fix python to have the modules I frequently use
  environment.systemPackages = [
    ( python.buildEnv.override  {
      extraLibs = with pkgs.python37Packages; [ # 3.7 because black fails on 3.8
        numpy
        ipython
        jupyter
        pandas

        # used by emacs::flymake-mode
        pyflakes

        # used by emacs::elpy-mode
        black
        jedi
        setuptools
        flake8
      ];
    })
  ] ++ (with pkgs; [ # and any simple deriviations relating to python;
    python37Packages.black
    python38Packages.pylint
    python38Packages.flake8
  ]);
}
