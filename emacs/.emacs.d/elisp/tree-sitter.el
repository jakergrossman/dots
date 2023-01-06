;;; tree-sitter.el
;;;
;;; tree sitter configuration

(require 'treesit)

(when (treesit-available-p)
  (setq-default rustic-treesitter-derive t))

(provide 'tree-sitter)
