;;;; Egon Kidmoses emacs configuration file. 
; created 08-may-2013

;; Load seperate files
; Git
(load "~/.emacs.d/git/git.el" nil t t)
; LaTeX
(load "~/.emacs.d/latex/latex.el" nil t t)
; C and cpp
(load "~/.emacs.d/c/c.el" nil t t)
; Global customisation
(load "~/.emacs.d/glob_cust/glob_cust.el" nil t t)
; term
(load "~/.emacs.d/term/term.el" nil t t)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-type-face ((t (:foreground "ForestGreen")))))
