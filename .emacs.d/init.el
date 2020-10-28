;;;; Egon Kidmoses emacs configuration file. 
; created 08-may-2013

;; Global customisation
(load "~/.emacs.d/glob_cust/glob_cust.el" nil t t)

;; ;; el-get
;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;; ;; Downloads el-get:
;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))
;; ;; Where to store recipes
;; (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; (el-get 'sync)
;; ;; My own init files pr. mode:
;; (setq el-get-user-package-directory "~/.emacs.d/el-get-init-files/")

;; ;; El get packages
;; (setq my-packages
;;       '(
;;         visual-fill-column
;; 	bash-completion
;; 	ein
;; 	el-get
;; 	markdown-mode
;; 	openwith
;; 	restclient
;;         ;; python-mode ;; need to run el-get-elpa-build-local-recipes ?
;;         ;; elpy
;;         ;; python
;;         ;; https://smythp.com/emacs/python/2016/04/27/pyenv-elpy.html
;;         flycheck ;; need to run el-get-elpa-build-local-recipes ?
;;         ;; py-autopep8
;;         ;; blacken
;;         ;; pyenv-mode f ;; manually installed dependency: f
;;         ;; pyenv-mode-auto
;; 	))
;; (el-get 'sync my-packages)

;; Trying out package.el and use-package
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(package-initialize)
;; Download use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;; Reduce load time
(eval-when-compile (require 'use-package))

(use-package org
  :mode (("\\.org$" . org-mode))
  :ensure org-plus-contrib
  :bind (:map org-mode-map
              ("C-c l" . org-store-link)
              ("C-c a" . org-agenda)
              )
  :config
  (progn
    (setq org-log-done t)
    (setq org-agenda-files (list "~/.caldav.org" "~/notes.org"))
    (setq org-todo-keywords
          '((sequence "TODO"  "WAITING" "BACKLOG" "|" "DONE" "DELEGATED" "SCRAPPED")))
    (setq org-agenda-sorting-strategy
          '((agenda habit-down time-up priority-down category-keep)
            (todo deadline-up timestamp-up todo-state-up)
            (tags priority-down category-keep)
            (search category-keep)))
    (add-to-list 'org-modules 'org-tempo)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((python . t)))
    (setq org-confirm-babel-evaluate nil)
    ))

(use-package tex
  :ensure auctex ; Because package and mode file names are not the same
  :config (load-file "~/.emacs.d/el-get-init-files/init-auctex.el") ;; TODO: Clean this up
  )

(use-package magit
  :ensure t
  :config
  (progn
    (setq magit-last-seen-setup-instructions "1.4.0")
    (setq magit-log-arguments (quote ("--graph" "--color" "--decorate" "-n256")))
    (setq magit-diff-refine-hunk (quote all))
    (add-hook 'magit-mode-hook (lambda () (toggle-truncate-lines -1))) ; Fold long lines
    ))

(use-package magit-gitflow
  :ensure t
  :after magit
  :config
  (progn
    (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
    (setq magit-gitflow-feature-start-arguments (quote ("--fetch")))
    ))

(use-package flyspell 
    :after (org python)
    :config
    (flyspell-mode))

(use-package visual-fill-column
  :ensure t
  :after (auctex)
  )

(use-package nix-mode
  :ensure t)

;; (use-package flycheck
;;   :ensure t
;;   :commands flycheck-mode
;;   :init (add-hook 'prog-mode-hook 'flycheck-mode)
;;   :config
;;   (progn
;;     (setq-default flycheck-emacs-lisp-initialize-packages t
;;                   flycheck-highlighting-mode 'lines
;;                   flycheck-check-syntax-automatically '(save)
;;                   flycheck-disabled-checkers '(c/c++-clang c/c++-gcc))
;;     ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(initial-scratch-message nil)
 '(ispell-dictionary "en_GB")
 '(package-selected-packages (quote (use-package org-plus-contrib)))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-type-face ((t (:foreground "ForestGreen")))))
