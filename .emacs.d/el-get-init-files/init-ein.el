(defun ipython-breakpoint-add()
  "Add a break point"
  (interactive)
  (beginning-of-line)
  (indent-according-to-mode)
  (insert "import ipdb; ipdb.set_trace()")
  (newline)
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

(add-hook 'ein:notebook-multilang-mode-hook
	  (lambda () (local-set-key (kbd "C-c C-d") 'ein:worksheet-delete-cell)))
(add-hook 'ein:notebook-multilang-mode-hook
	  (lambda () (local-set-key (kbd "C-M-c C-M-b") 'ein:worksheet-execute-cell-and-insert-below)))
(add-hook 'ein:notebook-multilang-mode-hook
	  (lambda () (local-set-key (kbd "C-M-c C-M-n") 'ein:worksheet-execute-cell-and-goto-next)))

(add-hook 'ein:notebook-multilang-mode-hook
	  (lambda () (local-set-key (kbd "C-c b") 'ipython-breakpoint-add)))

