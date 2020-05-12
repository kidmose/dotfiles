; (setq magit-gitflow-popup-key "C-F")
(require 'magit-gitflow)
(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)

(setq magit-last-seen-setup-instructions "1.4.0")
(setq magit-log-arguments (quote ("--graph" "--color" "--decorate" "-n256")))
(setq magit-diff-refine-hunk (quote all))
(setq magit-gitflow-feature-start-arguments (quote ("--fetch")))

(add-hook 'magit-mode-hook (lambda () (toggle-truncate-lines -1))) ; Fold long lines
