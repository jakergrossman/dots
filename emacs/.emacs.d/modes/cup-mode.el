;;;; cup-mode.el
;;;;
;;;; Minor mode for syntax highlighting in CUP files

(defvar cup-mode-hook nil)
(defvar cup-mode nil)

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

(define-minor-mode cup-mode
  "Toggles cup-mode for simple syntax highlighting in Java CUP files."
  nil
  :lighter " cup"
  (cond
   (cup-mode
    ;; Register highlighting
    (font-lock-add-keywords nil cup-font-lock-keywords)
    (font-lock-fontify-buffer))
   (t
    (font-lock-remove-keywords nil cup-font-lock-keywords)
    (font-lock-fontify-buffer))))

(provide 'cup-mode)
