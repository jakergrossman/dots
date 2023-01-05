;;; lsp.el
;;;
;;; Language Server Protocol and related settings

(use-package lsp-mode
  :custom
  (lsp-idle-delay 1.0))

(use-package rustic
  :after lsp-mode

  :bind (:map rustic-mode-map
              ("M-?" . lsp-find-references)
              ("C-c C-c r" . lsp-rename))

  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy"))

(provide 'lsp)
