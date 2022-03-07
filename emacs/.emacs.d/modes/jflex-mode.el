;;;; jflex-mode.el
;;;;
;;;; Minor mode for syntax highlighting in JFLEX files

(defvar jflex-mode-hook nil)
(defvar jflex-mode nil)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.jflex\\'" . jflex-mode))

(defconst jflex-font-lock-keywords
  (list
   '("^\\(%[a-zA-Z0-9_-]+\\|\\(%[{}]\\)\\)" . font-lock-keyword-face)
   '("^%%" . font-lock-warning-face)
   '("{[a-zA-Z]+}" . font-lock-type-face)
   '("\\(:\\(?:\\(?:digit\\|letter\\):\\)\\)" . font-lock-builtin-face)
   '("\"\\(\\\\[\\\\\"]\\|[^\\\\\"]\\)*\"" . font-lock-string-face)))

(define-minor-mode jflex-mode
  "Toggles jflex-mode for simple syntax highlighting in JFlex files."
  nil
  :lighter " jflex"
  (cond
   (jflex-mode
    ;; Register highlighting
    (font-lock-add-keywords nil jflex-font-lock-keywords)
    (font-lock-fontify-buffer))
   (t
    (font-lock-remove-keywords nil jflex-font-lock-keywords)
    (font-lock-fontify-buffer))))

(provide 'jflex-mode)
