;;;; term major mode
; familiar, but basic yank on "C-y" (no kill ring)
(add-hook 'term-mode-hook (lambda ()
                            (define-key term-raw-map (kbd "C-y") 'term-paste)))
