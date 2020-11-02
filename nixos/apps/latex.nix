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
      collection-fontsextra # dsfont.sty
      collection-fontsrecommended # scalable fonts
      collection-langenglish
      collection-langeuropean # danish in babel
      collection-latex
      collection-latexextra # fixme.sty
      collection-latexrecommended
      collection-pstricks # pstricks.sty
      collection-publishers # elsarticle.sty
      metafont # mf command line util for fonts (latex package ifsym)
      tex4ht # htlatex to build html
                      ;})
    evince
    ghostscript # for ps2pdf
  ];
}
