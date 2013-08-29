;;;; Egon Kidmoses emacs configuration file. 
; created 08-may-2013

;;;; Load seperate files
(load "~/.emacs.d/git/git.el" nil t t)

;;; LaTeX
(load "~/.emacs.d/latex/latex.el" nil t t)

;; Avoid accicential sleepingz
(global-unset-key (kbd "C-z"))

;;;; Unbind arrow movement, for training myself not to use proper keys
(global-unset-key [left])
(global-unset-key [up])
(global-unset-key [right])
(global-unset-key [down])

;; Use tab for indentation in c and cpp (CC major mode) when saving
 (setq-default c-basic-offset 2
                  tab-width 2
                  indent-tabs-mode t)


;; function definition
(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))


;; Clipboard to and from other programs
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

