;;;; Keybindings
;; Avoid accicential sleeping when running under x11
(if (eq window-system 'x) (global-unset-key (kbd "C-z")))

;;;; Unbind arrow movement, for training myself to use proper keys
;; (global-unset-key [left])
;; (global-unset-key [up])
;; (global-unset-key [right])
;; (global-unset-key [down])
; backspace functionality
;;(global-set-key (kbd "C-h") 'delete-backward-char)
;;(global-set-key (kbd "M-h") 'backward-kill-word)

;;;; custom function definition
(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

;; Clipboard to and from other programs
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; suppres splash screen when opening emacs
(setq inhibit-splash-screen t)

;; Avoid Emacs droppings (backup files will be put to temp folders)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

; Send files deleted by Emacs to Recycle bin
delete-by-moving-to-trash t

;;;; Visual 
;; Load dark theme (emacs24)
(load-theme 'tango-dark)

;; Enable functions that are disabled by default
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
