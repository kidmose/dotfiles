(add-hook 'ein:notebook-multilang-mode-hook
	  (lambda () (local-set-key (kbd "C-c C-d") 'ein:worksheet-delete-cell)))

