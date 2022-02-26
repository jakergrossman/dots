;;;; jflex-mode.el
;;;;
;;;; Minor mode for syntax highlighting in JFLEX files

(defvar-local jflex-mode-hook nil)
(defvar-local jflex-mode nil)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.jflex\\'" . jflex-mode))

(defconst jflex-font-lock-keywords
  (list
   '("^\\(%[a-zA-Z0-9_-]+\\|\\(%[{}]\\)\\)" . font-lock-keyword-face)
   '("^%%" . font-lock-warning-face)
   '("{[a-zA-Z]+}" . font-lock-type-face)
   '("\\(:\\(?:\\(?:digit\\|letter\\):\\)\\)" . font-lock-builtin-face)
   '("\"\\(\\\\[\\\\\"]\\|[^\\\\\"]\\)*\"" . font-lock-string-face)))

(defun jflex-mode (&optional arg)
  "Minor mode for JFLEX syntax highlighting"
  (interactive (list (or current-prefix-arg 'toggle)))
  (let ((enable
         (if (eq arg 'toggle)
             (not jflex-mode)
           (> (prefix-numeric-value arg) 0))))
    (if enable
        (progn
          (setq jflex-mode t)
          ;; Register highlighting
          (font-lock-add-keywords nil jflex-font-lock-keywords)

          (add-to-list 'minor-mode-alist '(jflex-mode " JFLEX")))
      (progn
        (setq jflex-mode nil)
        (font-lock-remove-keywords nil jflex-font-lock-keywords)))))

(provide 'jflex-mode)
