;;;; cup-mode.el
;;;;
;;;; Minor mode for syntax highlighting in CUP files

(defvar-local cup-mode-hook nil)
(defvar-local cup-mode nil)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.cup\\'" . cup-mode))

(defconst cup-font-lock-keywords
  (list
   '("//.*" . font-lock-comment-face)
   '("/\\*.*\\*/" . font-lock-comment-face)
   '("\\(import\\|package\\|start with\\)" . font-lock-warning-face)
   '("\\(\\(?:non \\)?terminal\\)" . font-lock-keyword-face)
   '("\\<[A-Z]+\\>" . font-lock-builtin-face)
   '("\\<\\([A-Z][a-z]*\\)+\\>" . font-lock-type-face)))

(defun cup-mode (&optional arg)
  "Minor mode for CUP syntax highlighting"
  (interactive (list (or current-prefix-arg 'toggle)))
  (let ((enable (if (eq arg 'toggle)
                    (not cup-mode)
                  (> (prefix-numeric-value arg) 0))))
    (setq cup-mode enable)
    (cond
      (enable
       ;; Register highlighting
       (font-lock-add-keywords nil cup-font-lock-keywords)
       (add-to-list 'minor-mode-alist '(cup-mode " CUP"))
       (font-lock-fontify-buffer))
      (t
       (font-lock-remove-keywords nil cup-font-lock-keywords)
       (font-lock-fontify-buffer)))))

(provide 'cup-mode)
