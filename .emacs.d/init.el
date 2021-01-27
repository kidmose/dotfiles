;;; kidmose-init -- "Egon Kidmoses emacs configuration file"
; created 08-may-2013
;;; Commentary:

;;; Code:

;;; TODO: Move it in here (use-package?)
(load "~/.emacs.d/glob_cust/glob_cust.el" nil t t)

;;;; Startup optimisation
;; (package-initialize)
;; suppres splash screen when opening emacs
(setq inhibit-splash-screen t
      package-enable-at-startup nil)
;; Disable (effectively) Garbage Collection at start-up (https://github.com/nilcons/emacs-use-package-fast#a-trick-less-gc-during-startup)
(setq gc-cons-threshold 64000000)
(add-hook 'after-init-hook #'(lambda ()
                               ;; restore after startup
                               (setq gc-cons-threshold 800000)))
(eval-when-compile
  (require 'use-package)) ; require 'use-package only when bytecompiling
(require 'bind-key) ;; because of using ":bind" below

;;;; setting up use-package related stuff
(setq package-archives
      '(("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("ORG"          . "http://orgmode.org/elpa/")
        ("GNU ELPA"     . "https://elpa.gnu.org/packages/")
        ("MELPA"        . "https://melpa.org/packages/")))
(setq package-archive-priorities
      '(("MELPA Stable" . 10)
        ("ORG"          . 10)
        ("GNU ELPA"     . 6)
        ("MELPA"        . 4)))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;;; Org stuff
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
    (setq org-agenda-files (list "~/org/"))
    (setq org-todo-keywords
          '((sequence "TODO"  "WAITING" "BACKLOG" "|" "DONE" "DELEGATED" "SCRAPPED")))
    (setq org-agenda-sorting-strategy
          '((agenda habit-down time-up priority-down category-keep)
            (todo deadline-up timestamp-up todo-state-up category-keep)
            (tags priority-down category-keep)
            (search category-keep)))
    (add-to-list 'org-modules 'org-tempo)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((shell . t)
       (python . t)))
    (setq org-confirm-babel-evaluate nil)
    ;; (defun org-reveal-tidy ()
    ;;   (interactive)
    ;;   "Reveal current entry, fold all others."
    ;;   (if (save-excursion (end-of-line) (outline-invisible-p))
    ;;       (progn (org-show-entry) (show-children))
    ;;     (outline-back-to-heading)
    ;;     (unless (and (bolp) (org-on-heading-p))
    ;;       (org-up-heading-safe)
    ;;       (hide-subtree)
    ;;       (error "Boundary reached"))
    ;;     (org-overview)
    ;;     (org-reveal t)
    ;;     (org-show-entry)
    ;;     (show-children)))
    (add-hook 'org-mode-hook 'flyspell-mode)
    ))

(use-package ox-md
  :ensure nil
  :after org)

;;;; LaTeX
(use-package tex
  :ensure auctex ; Because package and mode file names are not the same
  :defer t
  :bind (("M-p" . backward-paragraph)
         ("M-n" . forward-paragraph)
         ("M-q" . one-sentence-lines-paragraph)) ; Keybinding, replacing fill-paragraph with one-sentence-lines-paragraph
  :config
  (progn
    ;;;; Basics
    ;; Always latex-mode for tex files
    (add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))
    ;; Parse files for identifying BIBTeX, autocomplete etc.
    (setq TeX-auto-save t) ; parse when saving
    (setq TeX-parse-self t); parse when loading

    ;;;; Compiling
    ;; Multifile documents
    (setq-default TeX-master nil) ; Query for master file if not already set or read from file/directory variables
    ;; pdf output by default
    (setq TeX-PDF-mode t)
    ;; Add command to use Makefile
    (eval-after-load "tex" '(add-to-list 'TeX-command-list '("make" "make" TeX-run-compile nil t)))
    (eval-after-load "tex" '(add-to-list 'TeX-command-list '("make clean" "make clean" TeX-run-compile nil t)))
    (eval-after-load "tex" '(add-to-list 'TeX-command-list '("make target" "make " TeX-run-compile t t)))
    (eval-after-load "tex" '(setq compilation-scroll-output 'first-error)) ; scroll with output

    ;;;; Source correlation
    ;; Forward (Emacs to viewer) and inverse (Viewer to Emacs) search
    ;; Enables Source Specials for DVI/synctex for pdf
    (setq TeX-source-correlate-mode t)
    ;; Start server without prompt. Must be started for inverse search
    (setq TeX-source-correlate-start-server t)

    ;;;; Quotes and hyphens
    ;; Don't use danish quotation marks, use english even if danish babel is loaded ( https://www.gnu.org/software/auctex/manual/auctex/auctex_78.html#Style-Files-for-Different-Languages)
    (eval-after-load "tex" '(add-to-list 'TeX-quote-language-alist '("danish" "``" "''" nil)))
    ;; ;; Don't use danish hyphenation, use english even if danish babel is loaded ( https://www.gnu.org/software/auctex/manual/auctex/auctex_78.html#Style-Files-for-Different-Languages)
    ;; (eval-after-load "LaTeX" '(add-to-list 'LaTeX-babel-hyphen-language-alist '("danish" "-" )))
    ;; Disable fancy hyphenation from AucTex babel:
    (setq LaTeX-babel-hyphen nil)
    ;;;; Syntax highlighting
    ;; Don't let verbatim environments break syntax highlighting
    (setq LaTeX-verbatim-environments-local '("Verbatim" "lstlisting" "comment"))

    (defun align-environment ()
      "My (Egon Kidmose) own version; Apply align to the current environment only."
      (interactive)
      (save-excursion)
      (LaTeX-mark-environment)
      (align (point) (mark)))

    ;;; Paragraph filling
    ;; Alternative to fill-paragraph: Put one sentence per line.
    ;; http://www.cs.au.dk/~abizjak/emacs/2016/03/06/latex-fill-paragraph.html
    ;;
    ;; TODO: This is not working. Maybe I broke something now that I
    ;; took it into use-package, maybe it wasn't working. I recall
    ;; that it was "brittle" anyway...
    ;;
    (defun one-sentence-lines-paragraph (&optional P)
      "When called with prefix argument call `fill-paragraph'.
Otherwise split the current paragraph into one sentence per line."
      (interactive "P")
      (if (not P)
          (save-excursion
            (let ((fill-column 12345678)) ;; relies on dynamic binding
              (fill-paragraph) ;; this will not work correctly if the paragraph is
              ;; longer than 12345678 characters (in which case the
              ;; file must be at least 12MB long. This is unlikely.)
              (let ((end (save-excursion
                           (forward-paragraph 1)
                           (backward-sentence)
                           (point-marker))))  ;; remember where to stop
                (beginning-of-line)
                (while (progn (forward-sentence)
                              (<= (point) (marker-position end)))
                  (just-one-space) ;; leaves only one space, point is after it
                  (delete-char -1) ;; delete the space
                  (newline)        ;; and insert a newline
                  (LaTeX-indent-line) ;; I only use this in combination with late, so this makes sense
                  ))))
        ;; otherwise do ordinary fill paragraph
        (fill-paragraph P)))
    ;; Visual fill-column - http://emacshorrors.com/posts/longlines-mode.html#id4
    (add-hook 'LaTeX-mode-hook 'visual-line-mode) ; visual line mode does line wrapping at word boundaries without affecting file or nasty hacks.
    (add-hook 'visual-line-mode-hook 'visual-fill-column-mode) ; Makes visual lines mode use fill-column instead of just window width
    ;; Other hooks
    (add-hook 'LaTeX-mode-hook 'flyspell-mode)
    (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
    (add-hook 'LaTeX-mode-hook 'orgtbl-mode)
    ))

;; RefTeX
(use-package reftex
  :config (progn (setq reftex-plug-into-auctex t)
                 ;; Dont prompt if I want \ref or \pageref
                 (setq reftex-ref-macro-prompt nil)))

;;;; Python stuff
(use-package python
  :config (add-hook 'python-mode-hook 'flyspell-prog-mode))

(use-package elpy
  :defer t
  :init (advice-add 'python-mode :before 'elpy-enable)
  :config  (setq elpy-modules ;; Take away the Flymake that is causing
                              ;; trouble on nixos
                 (quote (elpy-module-company
                         elpy-module-eldoc
                         elpy-module-pyvenv
                         elpy-module-highlight-indentation
                         elpy-module-yasnippet
                         elpy-module-django
                         elpy-module-sane-defaults))) )

(use-package python-black
  :defer t
  :init (add-hook 'python-mode-hook 'python-black-on-save-mode)
  :config (setq python-black-command "black"))

(use-package ein
  :commands (ein:notebooklist-open))
;; ein from melpa stable is not supported
(add-to-list 'package-archive-priorities '(ein . "MELPA"))

;;;; Miscellaneous
(use-package magit
  :bind ("C-c s" . magit-status)
  :config
  (progn
    (setq magit-log-arguments (quote ("--graph" "--color" "--decorate" "-n256")))
    (setq magit-diff-refine-hunk (quote all))
    (setq magit-gitflow-feature-start-arguments (quote ("--fetch")))
    (add-hook 'magit-mode-hook (lambda () (toggle-truncate-lines -1))) ; Fold long lines
    ))

(use-package magit-gitflow
  :after magit
  :config
  (progn
    (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
    (setq magit-gitflow-feature-start-arguments (quote ("--fetch")))
    ))

(use-package visual-fill-column
  :after (auctex)
  )

(use-package nix-mode)

(use-package markdown-mode
  :config (add-hook 'markdown-mode-hook 'flyspell-mode))

(use-package yaml-mode)

(use-package openwith
  :config (progn
            (openwith-mode t)
            (setq openwith-associations (quote (
	                                        ("\\.pdf\\'" "evince" (file))
	                                        ("\\.jpg\\'" "eog" (file))
	                                        ("\\.jpeg\\'" "eog" (file))
	                                        ("\\.png\\'" "eog" (file))
	                                        ("\\.odt\\'" "libreoffice" (file))
	                                        ("\\.docx\\'" "libreoffice" (file))
	                                        ("\\.xlsx\\'" "libreoffice" (file))
                                                )))))
;; ;; Do not nag when openning large files
;; ;; Inspired by https://emacs.stackexchange.com/a/17096/8658
;; (defvar my-ok-large-file-types
;;   (concat
;;    "\\.\\("
;;    (mapconcat
;;     #'(lambda (arg) (string-trim arg (rx "\\.") (rx "\\'")))
;;     (mapcar 'car openwith-associations)
;;     "\\|"
;;     )
;;    "\\)\\'"
;;    )
;;   ;; (rx "." (or "mp4" "mkv") string-end)
;;   "Regexp matching filenames which are definitely ok to visit,
;; even when the file is larger than `large-file-warning-threshold'.")
;;
;; (defadvice abort-if-file-too-large (around my-check-ok-large-file-types)
;;   "If FILENAME matches `my-ok-large-file-types', do not abort."
;;   (unless (string-match-p my-ok-large-file-types (ad-get-arg 2))
;;     ad-do-it))
;; (ad-activate 'abort-if-file-too-large)

;;;; spell check, linting
(use-package flyspell
  :defer t)

(use-package flycheck
  :commands flycheck-mode
  :init (add-hook 'prog-mode-hook 'flycheck-mode)
  :config
  (progn
    (setq-default flycheck-emacs-lisp-initialize-packages t
                  flycheck-highlighting-mode 'lines
                  flycheck-check-syntax-automatically '(save)
                  flycheck-disabled-checkers '(c/c++-clang c/c++-gcc))
    ))

;;;; Emacs built-in customisation
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(initial-major-mode 'fundamental-mode)
 '(initial-scratch-message nil)
 '(ispell-dictionary "en_GB")
 '(org-agenda-span 'fortnight)
 '(package-selected-packages
   '(markdown-preview-eww impatient-mode yaml-mode visual-fill-column use-package python-black org-plus-contrib nix-mode magit-gitflow flycheck elpy ein edbi dockerfile-mode auctex))
 '(safe-local-variable-values '((encoding . utf-8))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-type-face ((t (:foreground "ForestGreen")))))

(provide 'init)
;;; init.el ends here
