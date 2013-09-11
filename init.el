;;;; Egon Kidmoses emacs configuration file. 
; created 08-may-2013

;; Load seperate files
; Git
(load "~/.emacs.d/git/git.el" nil t t)
; LaTeX
(load "~/.emacs.d/latex/latex.el" nil t t)
; Global customisation
(load "~/.emacs.d/glob_cust/glob_cust.el" nil t t)


;; Use tab for indentation in c and cpp (CC major mode) when saving
 (setq-default c-basic-offset 2
                  tab-width 2
                  indent-tabs-mode t)

