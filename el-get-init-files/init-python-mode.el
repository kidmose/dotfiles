;;(require 'elpy)
;;(add-hook 'python-mode-hook 'elpy-enable)

(require 'flycheck)
(add-hook 'python-mode-hook 'flycheck-mode)

;; (require 'py-autopep8)
;; (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

 
;; Builtin minor modes
(add-hook 'python-mode-hook 'linum-mode)

;; Some code I had arround for quite a while, not sure if/how to use it;
(defun python-add-breakpoint ()
  "Add a break point"
  (interactive)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))
(define-key python-mode-map (kbd "C-c C-b") 'python-add-breakpoint)

(defun remove-py-debug ()  
  "remove py debug code, if found"  
  (interactive)  
  (let ((x (line-number-at-pos))  
    (cur (point)))  
    (search-forward-regexp "^[ ]*import pdb; pdb.set_trace();")  
    (if (= x (line-number-at-pos))  
    (let ()  
      (move-beginning-of-line 1)  
      (kill-line 1)  
      (move-beginning-of-line 1))  
      (goto-char cur))))  

;; (define-key python-mode-map (kbd "C-c M-b") 'python-add-breakpoint)

(define-key python-mode-map (kbd "C-c ;") 'comment-or-uncomment-region)
