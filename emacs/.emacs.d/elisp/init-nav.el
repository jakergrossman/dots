;; jump around, jump around. Jump up, jump up and get down
(use-package avy
  :bind
  ("C-=" . avy-goto-char)
  :config
  (setq avy-background t))

(use-package multiple-cursors
  :config
  (bind-keys
   :map prog-mode-map
   :prefix "C-c m"
   :prefix-map multiple-cursors-map
   ("n"  . mc/mark-next-like-this)
   ("p"  . mc/mark-previous-like-this)
   ("<"  . mc/mark-all-like-this)
   ("a"  . mc/edit-beginnings-of-lines)
   ("e"  . mc/edit-ends-of-lines)
   ("\"" . mc/skip-to-next-like-this)
   (":"  . mc/skip-to-previous-like-this)
   ("l"  . mc/edit-lines)))

(use-package rg
  :config
  (rg-enable-default-bindings))

(use-package ace-window
  :bind ("C-x o" . ace-window))

;; like `:h single-repeat` in vim
(use-package dot-mode
  :delight
  :config
  (global-dot-mode))

(provide 'init-nav)
