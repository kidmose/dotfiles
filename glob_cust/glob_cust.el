;; Avoid accicential sleeping
(global-unset-key (kbd "C-z"))

;;;; Unbind arrow movement, for training myself not to use proper keys
(global-unset-key [left])
(global-unset-key [up])
(global-unset-key [right])
(global-unset-key [down])

;; function definition
(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))


;; Clipboard to and from other programs
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

; suppres splash screen when opening emacs
(setq inhibit-splash-screen t)
