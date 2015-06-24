;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(inhibit-startup-screen t))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  )

;;;; AucTex
;;(load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)
;; (setq TeX-auto-save t) ; parse when saving
;; (setq TeX-parse-self t); parse when loading
(setq TeX-PDF-mode t); pdf by default
(setq-default TeX-master nil) ; Query for master file.

;;;; RefTeX
(add-hook 'latex-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;(add-hook 'TeX-mode-hook #'(lambda ()
;                             (setq-local comment-padding " ")))
(setq reftex-plug-into-auctex t)

;; ;; Evince as pdf-viewer with two way search using dbus
;; ;http://www.emacswiki.org/emacs/AUCTeX#toc20
;; (require 'dbus)

;; (defun un-urlify (fname-or-url)
;;   "A trivial function that replaces a prefix of file:/// with just /."
;;   (if (string= (substring fname-or-url 0 8) "file:///")
;;       (substring fname-or-url 7)
;;     fname-or-url))

;; (defun th-evince-sync (file linecol &rest ignored)
;;   (let* ((fname (un-urlify file))
;;          (buf (find-buffer-visiting fname))
;;          (line (car linecol))
;;          (col (cadr linecol)))
;;     (if (null buf)
;;         (message "[Synctex]: %s is not opened..." fname)
;;       (switch-to-buffer buf)
;;       (goto-line (car linecol))
;;       (unless (= col -1)
;;         (move-to-column col)))))

;; (defvar *dbus-evince-signal* nil)

;; (defun enable-evince-sync ()
;;   (require 'dbus)
;;   (when (and
;;          (eq window-system 'x)
;;          (fboundp 'dbus-register-signal))
;;     (unless *dbus-evince-signal*
;;       (setf *dbus-evince-signal*
;;             (dbus-register-signal
;;              :session nil "/org/gnome/evince/Window/0"
;;              "org.gnome.evince.Window" "SyncSource"
;;              'th-evince-sync)))))

;; (add-hook 'LaTeX-mode-hook 'enable-evince-sync)

;; ;(setq-default TeX-master nil); ask for master when opening tex files
;; (put 'upcase-region 'disabled nil)


;;; Okular as pdfviewer with fwd and rev search
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(TeX-source-correlate-method (quote synctex))
;;  '(TeX-source-correlate-mode t)
;;  '(TeX-source-correlate-start-server t)
;;  '(TeX-view-program-list (quote (("Okular" "okular –unique %o#src:%n%b"))))
;;  '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "xpdf") (output-html "xdg-open") (output-pdf "Okular")))))
