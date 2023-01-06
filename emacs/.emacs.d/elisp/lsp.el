;;; lsp.el
;;;
;;; Language Server Protocol and related settings

(use-package lsp-mode
  :bind (:map lsp-mode-map
              ("C-c l" . flycheck-list-errors)
              ("C-c R" . lsp-rename)
              ("C-c r" . lsp-find-references)
              ("C-c D" . flymake-goto-prev-error)
              ("C-c d" . flymake-goto-next-error))

  :custom
  (lsp-idle-delay 1.0))

(use-package rustic
  :after lsp-mode
  :bind (:map rustic-mode-map
              ("M-?" . lsp-find-references)
              ("C-c C-c r" . lsp-rename))

  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (rustic-treesitter-derive t))

(provide 'lsp)
