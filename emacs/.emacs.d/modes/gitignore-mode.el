;;;; gitignore-mode.el
;;;;
;;;; Minor mode for syntax highlighting in gitignore files

(defvar gitignore-mode-hook nil)
(defvar gitignore-mode nil)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.gitignore\\'" . gitignore-mode))

(defconst gitignore-font-lock-keywords
  (list
   ;; comments
   '("^#.*" . font-lock-comment-face)

   ;; escaped characters
   '("\\\\." . font-lock-warning-face)

   ;; kleene * and ?
   '("[*?]" . font-lock-keyword-face)

   ;; directory separator
   '("[/]" . font-lock-builtin-face)

   ;; pattern negation
   '("^!" . font-lock-warning-face)))

(define-minor-mode gitignore-mode
  "Toggles gitignore-mode for simple syntax highlighting in .gitignore files."
  nil
  :lighter " gitignore"
  (cond
   (gitignore-mode
    ;; Register highlighting
    (font-lock-add-keywords nil gitignore-font-lock-keywords)
    (font-lock-fontify-buffer))
   (t
    (font-lock-remove-keywords nil gitignore-font-lock-keywords)
    (font-lock-fontify-buffer))))

(provide 'gitignore-mode)
