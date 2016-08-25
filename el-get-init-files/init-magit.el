(require 'magit-gitflow)
(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
(setq magit-last-seen-setup-instructions "1.4.0")
(setq magit-log-arguments (quote ("--graph" "--color" "--decorate" "-n256")))
