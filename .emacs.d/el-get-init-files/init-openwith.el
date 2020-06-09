(setq openwith-mode t)
(setq
 openwith-associations
 (quote(
	;; ("\\.mp4\\'" "evince" (file))
	;; ("\\.mkv\\'" "eog" (file))
	("\\.pdf\\'" "evince" (file))
	("\\.jpg\\'" "eog" (file))
	("\\.jpeg\\'" "eog" (file))
	("\\.png\\'" "eog" (file))
	("\\.odt\\'" "libreoffice" (file))
	("\\.docx\\'" "libreoffice" (file))
	)))

;; Do not nag when openning large files
;; Inspired by https://emacs.stackexchange.com/a/17096/8658
(defvar my-ok-large-file-types
  (concat
   "\\.\\("
   (mapconcat
    #'(lambda (arg) (string-trim arg (rx "\\.") (rx "\\'")))
    (mapcar 'car openwith-associations)
    "\\|"
    )
   "\\)\\'"
   )
  ;; (rx "." (or "mp4" "mkv") string-end)
  "Regexp matching filenames which are definitely ok to visit,
even when the file is larger than `large-file-warning-threshold'.")

(defadvice abort-if-file-too-large (around my-check-ok-large-file-types)
  "If FILENAME matches `my-ok-large-file-types', do not abort."
  (unless (string-match-p my-ok-large-file-types (ad-get-arg 2))
    ad-do-it))
(ad-activate 'abort-if-file-too-large)
