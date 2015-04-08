;;;; Egon Kidmoses emacs configuration file. 
; created 08-may-2013

;; Load seperate files
; Git
;(load "~/.emacs.d/git/git.el" nil t t)
; LaTeX
;(load "~/.emacs.d/latex/latex.el" nil t t)
; C and cpp
;(load "~/.emacs.d/c/c.el" nil t t)
; Global customisation
(load "~/.emacs.d/glob_cust/glob_cust.el" nil t t)
; term
;(load "~/.emacs.d/term/term.el" nil t t)

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(setq el-get-user-package-directory "~/.emacs.d/el-get-init-files/")

;; El get packages
(setq my-packages
      '(
	el-get
	ein
	magit
	magit-gitflow
	))
(el-get 'sync my-packages)


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
