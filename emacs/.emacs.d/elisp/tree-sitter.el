;;; tree-sitter.el
;;;
;;; tree sitter configuration

(require 'treesit)

(when (treesit-available-p)
  (require 'rust-ts-mode)         ; need to steal this for rustic-mode

  (define-derived-mode rustic-ts-mode rustic-mode "Rust"
    "Major mode for editing Rust, powered by tree-sitter and Rustic."
    :group 'rust
    :syntax-table rustic-ts-mode--syntax-table
    (when (treesit-ready-p 'rust)
      (treesit-parser-create 'rust)

      ;; Comments.
      (c-ts-mode-comment-setup)

      ;; Font-lock.
      (setq-local treesit-font-lock-settings rust-ts-mode--font-lock-settings)
      (setq-local treesit-font-lock-feature-list
                  '((comment)
                    (keyword string)
                    (attribute builtin constant escape-sequence
                               function number property type variable)
                    (bracket delimiter error operator)))

      ;; Imenu.
      (setq-local treesit-simple-imenu-settings
                  `(("Module" "\\`mod_item\\'" nil nil)
                    ("Enum" "\\`enum_item\\'" nil nil)
                    ("Impl" "\\`impl_item\\'" nil nil)
                    ("Type" "\\`type_item\\'" nil nil)
                    ("Struct" "\\`struct_item\\'" nil nil)
                    ("Fn" "\\`function_item\\'" nil nil)))

      ;; Indent.
      (setq-local indent-tabs-mode nil
                  treesit-simple-indent-rules rust-ts-mode--indent-rules)

      ;; Navigation.
      (setq-local treesit-defun-type-regexp
                  (regexp-opt '("enum_item"
                                "function_item"
                                "impl_item"
                                "struct_item")))
      (setq-local treesit-defun-name-function #'rust-ts-mode--defun-name)
      (treesit-major-mode-setup)))

  (defvar rc/treesit--mode-remap-alist
    '((rust-mode . rust-ts-mode)
      (rustic-mode . rustic-ts-mode)
      (c-mode . c-ts-mode)
      (c++-mode . c++-ts-mode)
      (python-mode . python-ts-mode))
    "Association list for overriding base modes in favor of tree-sitter wrappers.")

  (dolist (mode rc/treesit--mode-remap-alist)
    (add-to-list 'major-mode-remap-alist mode))

  (provide 'tree-sitter))
