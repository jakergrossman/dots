;;;; gitignore-mode.el
;;;;
;;;; Minor mode for syntax highlighting in gitignore files

(require 'dired)

(defvar-local gitignore-mode-hook nil)
(defvar-local gitignore-mode nil)

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

(defun gitignore-mode (&optional arg)
  "Minor mode for GITIGNORE syntax highlighting"
  (interactive (list (or current-prefix-arg 'toggle)))
  (let ((enable (if (eq arg 'toggle)
                    (not gitignore-mode)
                  (> (prefix-numeric-value arg) 0))))
    (setq gitignore-mode enable)
    (cond
     (enable
      ;; Register highlighting
      (font-lock-add-keywords nil gitignore-font-lock-keywords)
      (add-to-list 'minor-mode-alist '(gitignore-mode " GITIGNORE"))
      (font-lock-fontify-buffer))
     (t
      (font-lock-remove-keywords nil gitignore-font-lock-keywords)
      (font-lock-fontify-buffer)))))

(provide 'gitignore-mode)
