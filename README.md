README for my .emacs.d
======================

Git repository for my emacs configuration.

Installing emacs 24.4
---------------------

I'm om linux mint 17.3 (and other debian-based), not satisfied with the version in official repos (magit requires 24.4):

    sudo apt-add-repository -y ppa:adrozdoff/emacs\
     && sudo apt-get update\
     && sudo apt-get install -y emacs25

Installing git
--------------

    sudo add-apt-repository -y ppa:git-core/ppa\
     && sudo apt-get update

Mixed dependencies:
-------------------

    sudo apt-get install -y\
     autoconf\
     build-essential\
     git\
     git-flow\
     install-info\
     markdown\
     texlive-base\
     texlive-binaries\
     texlive-latex-base
