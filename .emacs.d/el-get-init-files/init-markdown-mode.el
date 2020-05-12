(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Spaces, not tabs, for indentation
(add-hook 'markdown-mode-hook (lambda ()
				(setq indent-tabs-mode nil)))
