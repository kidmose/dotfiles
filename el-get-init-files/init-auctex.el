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
;; Add command to use Makefile
(eval-after-load "tex" '(add-to-list 'TeX-command-list '("make" "make" TeX-run-compile nil t)))
(eval-after-load "tex" '(add-to-list 'TeX-command-list '("make clean" "make clean" TeX-run-compile nil t)))
(eval-after-load "tex" '(setq compilation-scroll-output 'first-error)) ; scroll with output
;; Don't use danish quatation marks, use english even if danish babel is loaded ( https://www.gnu.org/software/auctex/manual/auctex/auctex_78.html#Style-Files-for-Different-Languages)
(eval-after-load "tex" '(add-to-list 'TeX-quote-language-alist '("danish" "``" "''" nil)))
;; Disable fancy hyphenation from AucTex babel:
(setq LaTeX-babel-hyphen nil)
;; Don't use danish hyphenation, use english even if danish babel is loaded ( https://www.gnu.org/software/auctex/manual/auctex/auctex_78.html#Style-Files-for-Different-Languages)
;; (eval-after-load "LaTeX" '(add-to-list 'LaTeX-babel-hyphen-language-alist '("danish" "-" )))

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

(defun align-environment ()
  "Apply align to the current environment only."
  (interactive)
  (save-excursion)
  (LaTeX-mark-environment)
  (align (point) (mark)))


;;; Paragraph filling
;; Alternative to fill-paragraph: Put one sentence per line.
;; http://www.cs.au.dk/~abizjak/emacs/2016/03/06/latex-fill-paragraph.html
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
;; Keybinding, replacing fill-paragraph with one-sentence-lines-paragraph
(eval-after-load "LaTeX" '(define-key LaTeX-mode-map (kbd "M-q") 'one-sentence-lines-paragraph))
;; Visual fill-column - http://emacshorrors.com/posts/longlines-mode.html#id4
(add-hook 'LaTeX-mode-hook 'visual-line-mode) ; visual line mode does line wrapping at word boundaries without affecting file or nasty hacks. 
(require 'visual-fill-column)
(add-hook 'visual-line-mode-hook 'visual-fill-column-mode) ; Makes visual lines mode use fill-column instead of just window width
