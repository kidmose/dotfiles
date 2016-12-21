;; AucTex
;; Always latex-mode for tex files
(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))
;; Parse files for identifying BIBTeX, autocomplete etc. 
(setq TeX-auto-save t) ; parse when saving
(setq TeX-parse-self t); parse when loading
;; Multifile documents
(setq-default TeX-master nil) ; Query for master file if not already set or read from file/directory variables
;; work around an emacs 24.3 ispell bug
;; https://lists.gnu.org/archive/html/bug-auctex/2013-12/msg00010.html
(add-hook 'TeX-mode-hook (lambda () (setq-local comment-padding " ")))
;; pdf output by default
(setq TeX-PDF-mode t)

;; RefTeX
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-auctex t)
;; Dont prompt if I want \ref or \pageref
(setq reftex-ref-macro-prompt nil)
;; Forward (Emacs to viewer) and inverse (Viewer to Emacs) search
;; Enables Source Specials for DVI/synctex for pdf
(setq TeX-source-correlate-mode t)
;; Start server without prompt. Must be started for inverse search
(setq TeX-source-correlate-start-server t)

;; org-mode's minor mode; orgtbl-mode
(require 'org)
(add-hook 'LaTeX-mode-hook 'orgtbl-mode)
