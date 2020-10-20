# My setup for working with LaTeX
{ config, pkgs, ... }:
{
  imports =
    [
      ./emacs.nix # I'm sure this can be done more "nixy"
    ];
  
  environment.systemPackages = with pkgs; [
    # LaTeX stuff
    (texlive.combine {inherit (texlive) scheme-minimal
      collection-langeuropean # danish in babel
      collection-langenglish
      collection-publishers # elsarticle.sty
      collection-fontsextra # dsfont.sty
      collection-fontsrecommended # scalable fonts
      collection-latex
      collection-latexrecommended
      collection-latexextra # fixme.sty
      metafont # mf command line util for fonts (latex package ifsym)
      tex4ht # htlatex to build html
                      ;})
    evince
  ];
}
